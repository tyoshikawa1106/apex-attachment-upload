public with sharing class AttachmentUploaderHelper {

    /**
     * コンストラクタ
     */
    public AttachmentUploaderHelper() {
        
    }

    /**
     * 添付ファイルのBody情報取得
     */
    public Blob getAttachmentBody(Blob attachmentBody, String addAttchmentBody) {
        String newBody = '';
        if(attachmentBody != null) {
            newBody = EncodingUtil.base64Encode(attachmentBody);
        }
        newBody += addAttchmentBody;
        return EncodingUtil.base64Decode(newBody);
    }

    /**
     * 添付ファイル登録情報をセット(添付ファイルIDが存在しない新規の場合)
     */
    public Attachment setAttachmentInfo(Attachment attachment, String accountId, String attachmentId, String attachmentName) {
        if(String.isEmpty(attachmentId)) {
            attachment.Name = attachmentName;
            attachment.parentId = accountId;
        }
        return attachment;
    }
}