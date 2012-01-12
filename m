From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Client can't unmount, some pinned dentries in cache.
Date: Thu, 12 Jan 2012 20:01:04 +0400
Message-ID: <CAADCt4LwdnVeXBZRP1-WO_2XnXAKvZ0KThF5Hk_tZGh2X0=MDA@mail.gmail.com>
References: <CAADCt4LZSayxYfWmQ7He09eSxkvBzh-5FyB2hyDkUcBCsCjTGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d975b877f95104b656dc47
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49449 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab2ALQBa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 11:01:30 -0500
Received: by werm1 with SMTP id m1so1455438wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 08:01:29 -0800 (PST)
In-Reply-To: <CAADCt4LZSayxYfWmQ7He09eSxkvBzh-5FyB2hyDkUcBCsCjTGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--0016e6d975b877f95104b656dc47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all.

I've drill down this bug. Ceph issues ->get() on inode in
ctor

dir_result_t::dir_result_t(Inode *in)
  : inode(in), offset(0), next_offset(2),
    release_count(0), start_shared_gen(0),
    buffer(0) {
  inode->get();
}

But don't deref in destructor. So it hard to
see, that problem can be in code like this

int Client::_opendir(Inode *in, dir_result_t **dirpp, int uid, int gid)
{
  *dirpp =3D new dir_result_t(in);
  if (!in->is_dir())
    return -ENOTDIR;
...
}

Patch attached.

2012/1/11 Andrey Stepachev <octo47@gmail.com>:
> Hi all.
>
> I have client hangs on unmount. Logs show, that
> some pinned entries in cache exists, but I can't understand
> what is going on and why they still referenced.
>
> 2012-01-11 15:29:27.168712 7f32f6ffd700 client.4915 unmounting: trim
> pass, size was 0+6
> 2012-01-11 15:29:27.168729 7f32f6ffd700 client.4915 unmounting: trim
> pass, size still 0+6
> 2012-01-11 15:29:27.168751 7f32f6ffd700 client.4915 dump_cache: inode
> 10000007dc3.head ref 1 dir 0 10000007dc3.head(ref=3D1
> cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D734
> mtime=3D2012-01-11 15:13:53.624282 caps=3Dp(0=3Dp) objectset[10000007dc3 =
ts
> 0/0 objects 1 dirty_or_tx 0] 0x1210d80)
> 2012-01-11 15:29:27.168767 7f32f6ffd700 client.4915 dump_cache: inode
> 10000007586.head ref 1 dir 0 10000007586.head(ref=3D1
> cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D714
> mtime=3D2012-01-11 12:39:00.960535 caps=3Dp(0=3Dp) objectset[10000007586 =
ts
> 0/0 objects 1 dirty_or_tx 0] 0x166d370)
> 2012-01-11 15:29:27.168779 7f32f6ffd700 client.4915 dump_cache: inode
> 1000000758d.head ref 1 dir 0 1000000758d.head(ref=3D1
> cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D734
> mtime=3D2012-01-11 15:25:09.622986 caps=3Dp(0=3Dp) objectset[1000000758d =
ts
> 0/0 objects 1 dirty_or_tx 0] 0x12111c0)
> 2012-01-11 15:29:27.168791 7f32f6ffd700 client.4915 dump_cache: inode
> 100000079df.head ref 2 dir 0 100000079df.head(ref=3D2
> cap_refs=3D{1024=3D0,2048=3D0,4096=3D0,8192=3D0} open=3D{1=3D0,2=3D0} mod=
e=3D100777
> size=3D1089 mtime=3D2012-01-11 15:26:23.780076 caps=3Dp(0=3Dp)
> objectset[100000079df ts 0/0 objects 1 dirty_or_tx 0] 0x12a99b0)
> 2012-01-11 15:29:27.168803 7f32f6ffd700 client.4915 dump_cache: inode
> 100000079e0.head ref 2 dir 0 100000079e0.head(ref=3D2
> cap_refs=3D{1024=3D0,2048=3D0,4096=3D0,8192=3D0} open=3D{1=3D0,2=3D0} mod=
e=3D100777
> size=3D734 mtime=3D2012-01-11 15:27:13.887592 caps=3Dp(0=3Dp)
> objectset[100000079e0 ts 0/0 objects 0 dirty_or_tx 0] 0x7f32f833cb00)
> 2012-01-11 15:29:27.168814 7f32f6ffd700 client.4915 dump_cache: inode
> 100000079d7.head ref 1 dir 0 100000079d7.head(ref=3D1
> cap_refs=3D{1024=3D0,2048=3D0} open=3D{1=3D0} mode=3D100777 size=3D734
> mtime=3D2012-01-11 12:40:14.325753 caps=3Dp(0=3Dp) objectset[100000079d7 =
ts
> 0/0 objects 1 dirty_or_tx 0] 0x1211750)
>
> --
> Andrey.



--=20
=D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9.

--0016e6d975b877f95104b656dc47
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-avoid-ref-counter-increment-in-case-of-nonexistent-d.patch"
Content-Disposition: attachment;
	filename="0001-avoid-ref-counter-increment-in-case-of-nonexistent-d.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxbyt2181

RnJvbSA3NmI4Yzg1ZGRmMDU5YTk3MWU5MDNmYmUyNWQ0NjlkMTc5OGJlMTE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgU3RlcGFjaGV2IDxvY3RvQHlhbmRleC10ZWFtLnJ1
PgpEYXRlOiBUaHUsIDEyIEphbiAyMDEyIDE5OjI2OjM0ICswNDAwClN1YmplY3Q6IFtQQVRDSF0g
YXZvaWQgcmVmIGNvdW50ZXIgaW5jcmVtZW50IGluIGNhc2Ugb2Ygbm9uZXhpc3RlbnQgZGlyCgot
LS0KIHNyYy9jbGllbnQvQ2xpZW50LmNjIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NsaWVudC9DbGll
bnQuY2MgYi9zcmMvY2xpZW50L0NsaWVudC5jYwppbmRleCAwYWVkMGIyLi5jMGNlYmNiIDEwMDY0
NAotLS0gYS9zcmMvY2xpZW50L0NsaWVudC5jYworKysgYi9zcmMvY2xpZW50L0NsaWVudC5jYwpA
QCAtNDE0MCw5ICs0MTQwLDkgQEAgaW50IENsaWVudDo6b3BlbmRpcihjb25zdCBjaGFyICpyZWxw
YXRoLCBkaXJfcmVzdWx0X3QgKipkaXJwcCkKIAogaW50IENsaWVudDo6X29wZW5kaXIoSW5vZGUg
KmluLCBkaXJfcmVzdWx0X3QgKipkaXJwcCwgaW50IHVpZCwgaW50IGdpZCkgCiB7Ci0gICpkaXJw
cCA9IG5ldyBkaXJfcmVzdWx0X3QoaW4pOwogICBpZiAoIWluLT5pc19kaXIoKSkKICAgICByZXR1
cm4gLUVOT1RESVI7CisgICpkaXJwcCA9IG5ldyBkaXJfcmVzdWx0X3QoaW4pOwogICAoKmRpcnBw
KS0+c2V0X2ZyYWcoaW4tPmRpcmZyYWd0cmVlWzBdKTsKICAgaWYgKGluLT5kaXIpCiAgICAgKCpk
aXJwcCktPnJlbGVhc2VfY291bnQgPSBpbi0+ZGlyLT5yZWxlYXNlX2NvdW50OwotLSAKMS43LjUu
NAoK
--0016e6d975b877f95104b656dc47--
