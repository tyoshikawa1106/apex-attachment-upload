public with sharing class AttachmentUploaderDao {

    /**
     * コンストラクタ
     */
    public AttachmentUploaderDao() {
        
    }

    /**
     * 添付ファイル情報取得
     */
    public Attachment getAttachment(String attachmentId) {
        List<Attachment> attachments = [
            SELECT
                 Id
                ,Body
            FROM
                Attachment 
            WHERE
                Id =: attachmentId
            LIMIT 1
        ];

        return attachments.isEmpty() ? new Attachment() : attachments[0];
    }
}