package kr.or.kpc.dto;

public class NoticeDto2 {
	private int num;
	private String writer;
	private String title;
	private String content;
	private String regdate;
	
	public NoticeDto2() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NoticeDto2(int num, String writer, String title, String content, String regdate) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	

}
