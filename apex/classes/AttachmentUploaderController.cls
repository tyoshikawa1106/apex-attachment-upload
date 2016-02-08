public with sharing class AttachmentUploaderController {

    private static AttachmentUploaderHelper helper = new AttachmentUploaderHelper();
    private static AttachmentUploaderDao dao = new AttachmentUploaderDao();

    /**
     * コンストラクタ
     */
    public AttachmentUploaderController() {
        
    }

    /**
     * 取引先情報の登録
     */
    @RemoteAction
    public static AttachmentUploaderRemotingResult doSaveAccount(Account account) {
        AttachmentUploaderRemotingResult result = new AttachmentUploaderRemotingResult();
        
        try {
            insert account;
            result.recordId = account.Id;
        } catch(DmlException e) {
            result.errorMessages.add(e.getDmlMessage(0));
            return result;
        } catch(Exception e) {
            result.errorMessages.add(e.getMessage());
            return result;
        }
        
        return result;
    }

    /**
     * 添付ファイルの登録
     */
    @RemoteAction
    public static AttachmentUploaderRemotingResult doSaveAttachment(String parentId, String attachmentId, String fileName, String contentType, String base64BlobValue) {
        AttachmentUploaderRemotingResult result = new AttachmentUploaderRemotingResult();

        try {
            // 添付ファイルIDを条件に添付ファイル情報を取得
            Attachment attachment = dao.getAttachment(attachmentId);
            // 添付ファイルのBody情報を取得
            attachment.Body = helper.getAttachmentBody(attachment.Body, base64BlobValue);
            // 添付ファイル登録情報をセット(添付ファイルIDが存在しない新規の場合)
            helper.setAttachmentInfo(attachment, parentId, attachmentId, fileName);
            // 登録処理実行
            upsert attachment;
            // 戻り値IDをセット
            result.recordId = attachment.Id;
        } catch(DmlException e) {
            result.errorMessages.add(e.getDmlMessage(0));
            return result;
        } catch(Exception e) {
            result.errorMessages.add(e.getMessage());
            return result;
        }

        return result;
    }
}