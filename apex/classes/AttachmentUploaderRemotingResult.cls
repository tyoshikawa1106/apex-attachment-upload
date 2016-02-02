public with sharing class AttachmentUploaderRemotingResult {

    public Id recordId {get; set;}
    public List<String> errorMessages {get; set;}

    /**
     * コンストラクタ
     */
    public AttachmentUploaderRemotingResult() {
        this.recordId = null;
        this.errorMessages = new List<String>();
    }
}