package app.comment;

public class Comment {
	private int commentId;
	private int bbsId;
	private String writer;
	private String comment_content;
	private String comment_datetime;
	
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getBbsId() {
		return bbsId;
	}
	public void setBbsId(int bbsId) {
		this.bbsId = bbsId;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public String getComment_datetime() {
		return comment_datetime;
	}
	public void setComment_datetime(String comment_datetime) {
		this.comment_datetime = comment_datetime;
	}
	
	
}
