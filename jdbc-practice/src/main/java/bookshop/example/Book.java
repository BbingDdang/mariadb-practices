package bookshop.example;

public class Book {
	private int bookNo;
	private String title;
	private String author;
	private int stateCode;
	
	public Book(int bookNo, String title, String author) {
		this.bookNo = bookNo;
		this.title = title;
		this.author = author;
		this.stateCode = 1;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	public void rent(int bookNo) {
		if (this.stateCode == 0) {
			System.out.println("대여 중");
		}
		else {
			this.stateCode = 0;
			System.out.println(this.title + "이(가) 대여 됐습니다.");
		}
		
	}
	
	
	
	@Override
	public String toString() {
		if (stateCode == 1) {
			return "[" + bookNo + "]" + "책 제목:" + title + ", 작가:" + author + ", 대여 유무:재고있음";
		}
		else {
			return "[" + bookNo + "]" + "책 제목:" + title + ", 작가:" + author + ", 대여 유무:대여 중";
		}
		
	}

	public void print(Book books) {
		System.out.println(books.toString());  
		
		
	}
		
}
