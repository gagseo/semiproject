package up.member.model.service;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import common.JDBCTemplate;
import up.member.model.dao.MemberDao;
import up.member.model.vo.Member;

public class MemberService {

	JDBCTemplate jdt = JDBCTemplate.getInstance();
	MemberDao md = new MemberDao();

	/**
	 * @MethodName: loginImple
	 * @ClassName: MemberService.java
	 * @변경이력: 완료
	 * @Comment: login 시, 전달받은 id와 pw와 동일한 회원정보를 찾아 재전달
	 * @작성자: 박혜연
	 * @작성일: 2020. 4. 30.
	 */
	public Member loginImple(String userId, String userPwd) {
		Member result = null;
		Connection con = jdt.getConnection();

		try {
			result = new Member();
			result = md.loginImple(con, userId, userPwd);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdt.close(con);
		}

		return result;
	}

	/**
	 * @MethodName: idCheck
	 * @ClassName: MemberService.java
	 * @변경이력: 완료
	 * @Comment: 회원가입 전 id 중복 체크기능
	 * @작성자: 박혜연
	 * @작성일: 2020. 4. 30.
	 */
	public String idCheck(String userId) {
		String result = "";
		Connection con = jdt.getConnection();

		try {
			result = md.idCheck(con, userId);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdt.close(con);
		}

		return result;
	}

	/**
	 * @MethodName: register
	 * @ClassName: MemberService.java
	 * @변경이력: 완료
	 * @Comment: 회원정보 DB insert
	 * @작성자: 박혜연
	 * @작성일: 2020. 5. 1.
	 */
	public int insertMember(Member m) {
		int result = 0;
		Connection con = jdt.getConnection();

		try {
			result = md.insertMember(con, m);
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			jdt.close(con);
		}

		return result;
	}

	public void regEmailCheck(Member m) {

		// 구글 smtp 서버를 사용하기 위한 인증 정보
		PasswordAuthentication pa = new PasswordAuthentication("eternita9210", "qkrahdcl92@");

		// 사용할 smtp 서버 설정
		// smtp: send mail transfer protocol
		// 설정하지 않으면 우리가 smtp서버여야 한다.
		Properties prop = System.getProperties();
		// 1. tls(ssl)암호화 사용여부
		// 전송데이터의 암호화 여부
		prop.put("mail.smtp.starttls.enable", "true");
		// 2. 구글 smtp 서버 사용여부
		prop.put("mail.smtp.host", "smtp.gmail.com");
		// 3. smtp 서버에 접근할 때 사용자 인증 여부
		prop.put("mail.smtp.auth", "true");
		// 4. smtp 서버의 포트 번호
		prop.put("mail.stmp.port", "587");

		Session session = Session.getDefaultInstance(prop, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return pa;
			}
		});

		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("admin@up.com", "운영자"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(m.getUserEmail(), m.getUserId()));
			msg.setSubject(m.getUserId() + "님, 사이트 가입을 환영합니다.");

			String htmlBody = "<form action='http://localhost:8787/up/member/insert.do'"
					+ " method='post'><h3>회원 가입 완료를 원하시면 버튼을 클릭하세요</h3>" + "<input type='hidden' value='"
					+ m.getUserId() + "' name='userId'>" + "<input type='hidden' value='" + m.getUserPwd()
					+ "' name='userPwd'>" + "<input type='hidden' value='" + m.getUserEmail() + "' name='userEmail'>"
					+ "<input type='hidden' value='" + m.getUserName() + "' name='userName'>"
					+ "<input type='hidden' value='" + m.getUserNickName() + "' name='userNickName'>"
					+ "<button type='submit'>회원가입하기</button></form>";
			Multipart mp = new MimeMultipart();

			MimeBodyPart htmlPart = new MimeBodyPart();
			htmlPart.setContent(htmlBody, "text/html; charset=UTF-8");
			mp.addBodyPart(htmlPart);

			msg.setContent(mp);

			Transport.send(msg);
		} catch (AddressException e) {
			// ...
		} catch (MessagingException e) {
			// ...
		} catch (UnsupportedEncodingException e) {
			// ...
		}
	}

	/**
	 * @MethodName: findid
	 * @ClassName: MemberService.java
	 * @변경이력: 완료
	 * @Comment: ID 찾기 기능
	 * @작성자: 박혜연
	 * @작성일: 2020. 5. 1.
	 */
	public void findid(String userEmail) {
		Member result = new Member();
		Connection con = jdt.getConnection();

		try {
			result = md.findId(con, userEmail);

			PasswordAuthentication pa = new PasswordAuthentication("eternita9210", "qkrahdcl92@");

			Properties prop = System.getProperties();
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.host", "smtp.gmail.com");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.stmp.port", "587");

			Session session = Session.getDefaultInstance(prop, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			});

			try {
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("admin@up.com", "운영자"));
				msg.addRecipient(Message.RecipientType.TO,
						new InternetAddress(result.getUserEmail(), result.getUserId()));
				msg.setSubject(result.getUserNickName() + "님, 회원 ID을 보내드립니다.");

				String htmlBody = "<form action='http://localhost:8787/up/member/login.do' method='post'>"
						+ "<h3>회원 ID를 잊으셨나요?</h3>" + "<pre>" + result.getUserNickName()
						+ "님의 회원 ID는 <strong id='userId'>" + result.getUserId() + "</strong> 입니다.</pre>"
						+ "<button type='submit'>로그인 하기</button></form>";
				Multipart mp = new MimeMultipart();

				MimeBodyPart htmlPart = new MimeBodyPart();
				htmlPart.setContent(htmlBody, "text/html; charset=UTF-8");
				mp.addBodyPart(htmlPart);

				msg.setContent(mp);

				Transport.send(msg);
			} catch (AddressException e) {
				// ...
			} catch (MessagingException e) {
				// ...
			} catch (UnsupportedEncodingException e) {
				// ...
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @MethodName: findPwd
	 * @ClassName: MemberService.java
	 * @변경이력: 완료
	 * @Comment: 입력받은 이메일 주소로 임시 비밀번호 발송 및 DB 회원정보 중 비밀번호 변경
	 * @작성자: 박혜연
	 * @작성일: 2020. 5. 1.
	 */
	public void findPwd(String userId, String userEmail) {
		Member result = new Member();
		int res = 0;
		Connection con = jdt.getConnection();
		try {
			result = md.findPwd(con, userId, userEmail);

			PasswordAuthentication pa = new PasswordAuthentication("eternita9210", "qkrahdcl92@");

			Properties prop = System.getProperties();
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.host", "smtp.gmail.com");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.stmp.port", "587");

			Session session = Session.getDefaultInstance(prop, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			});

			try {
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("admin@up.com", "운영자"));
				msg.addRecipient(Message.RecipientType.TO,
						new InternetAddress(result.getUserEmail(), result.getUserId()));
				msg.setSubject(result.getUserId() + "님, 임시 비밀번호를 보내드립니다.");

				String htmlBody = "<form action='http://localhost:8787/up/member/login.do' method='post'>"
						+ "<h3>회원 비밀번호를 잊으셨나요?</h3>" + "<pre>" + result.getUserId() + "님의 임시 비밀번호는 <strong id='newPwd'>"
						+ result.getUserPwd() + "</strong> 입니다.</pre>" + "<button type='submit'>로그인 하기</button></form>";
				Multipart mp = new MimeMultipart();

				MimeBodyPart htmlPart = new MimeBodyPart();
				htmlPart.setContent(htmlBody, "text/html; charset=UTF-8");
				mp.addBodyPart(htmlPart);

				msg.setContent(mp);

				Transport.send(msg);

			} catch (AddressException e) {
				// ...
			} catch (MessagingException e) {
				// ...
			} catch (UnsupportedEncodingException e) {
				// ...
			}

			con.commit();

		} catch (SQLException e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

}
