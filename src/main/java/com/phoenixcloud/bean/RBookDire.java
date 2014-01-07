package com.phoenixcloud.bean;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigInteger;
import java.util.Date;


/**
 * The persistent class for the r_book_dire database table.
 * 
 */
@Entity
@Table(name="r_book_dire")
public class RBookDire extends AbstractModel<String> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="DIRE_ID", unique=true, nullable=false)
	private String direId;

	@Column(name="B_PAGE_NUM", nullable=false)
	private BigInteger bPageNum;

	@Column(name="BOOK_ID", nullable=false)
	private BigInteger bookId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_TIME", nullable=false)
	private Date createTime;

	@Column(name="DELETE_STATE", nullable=false)
	private byte deleteState;

	@Column(name="E_PAGE_NUM", nullable=false)
	private BigInteger ePageNum;

	@Column(nullable=false)
	private byte level;

	@Column(nullable=false, length=60)
	private String name;

	@Column(length=255)
	private String notes;

	@Column(name="STAFF_ID", nullable=false)
	private BigInteger staffId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="UPDATE_TIME", nullable=false)
	private Date updateTime;
	
	@Column(name="PARENT_DIRE_ID")
	private BigInteger parentDireId;

	public RBookDire() {
	}

	public String getDireId() {
		return this.direId;
	}

	public void setDireId(String direId) {
		this.direId = direId;
	}

	public BigInteger getBPageNum() {
		return this.bPageNum;
	}

	public void setBPageNum(BigInteger bPageNum) {
		this.bPageNum = bPageNum;
	}

	public BigInteger getBookId() {
		return this.bookId;
	}

	public void setBookId(BigInteger bookId) {
		this.bookId = bookId;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public byte getDeleteState() {
		return this.deleteState;
	}

	public void setDeleteState(byte deleteState) {
		this.deleteState = deleteState;
	}

	public BigInteger getEPageNum() {
		return this.ePageNum;
	}

	public void setEPageNum(BigInteger ePageNum) {
		this.ePageNum = ePageNum;
	}

	public byte getLevel() {
		return this.level;
	}

	public void setLevel(byte level) {
		this.level = level;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNotes() {
		return this.notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public BigInteger getStaffId() {
		return this.staffId;
	}

	public void setStaffId(BigInteger staffId) {
		this.staffId = staffId;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public BigInteger getParentDireId() {
		return parentDireId;
	}

	public void setParentDireId(BigInteger parentDireId) {
		this.parentDireId = parentDireId;
	}

	@Override
	public String getId() {
		// TODO Auto-generated method stub
		return direId;
	}

}