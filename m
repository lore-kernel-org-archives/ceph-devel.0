From: Chuanyu Tsai <chuanyu@cs.nctu.edu.tw>
Subject: Re:
Date: Mon, 2 Jul 2012 09:35:13 +0000 (UTC)
Message-ID: <loom.20120702T112254-414@post.gmane.org>
References: <4FD71854.6060503@hastexo.com> <CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com> <CAC-hyiEDLJTkDKXLgR64cPE5mcPvWUCs6kCCq+DiRaCtvDEEFQ@mail.gmail.com> <4FD78636.9080607@hastexo.com> <CAC-hyiF5PVR9nzjewG6VjPCGdjAeuio8Gqf9_juZKWRZZ1KpaQ@mail.gmail.com> <loom.20120701T222011-780@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42956 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932718Ab2GBJfc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Jul 2012 05:35:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sld2U-0008Kx-GW
	for ceph-devel@vger.kernel.org; Mon, 02 Jul 2012 11:35:29 +0200
Received: from ccis13.cs.nctu.edu.tw ([140.113.207.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 11:35:26 +0200
Received: from chuanyu by ccis13.cs.nctu.edu.tw with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 11:35:26 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Chuanyu <chuanyu <at> cs.nctu.edu.tw> writes:
> Hi Yehuda, Florian,
> 
> I follow the wiki, and steps which you discussed,
> construct my ceph system with rados gateway,
> and I can use libs3 to upload file via radosgw, (thanks a lot!)
> but got "405 Method Not Allowed" when I use swift,
> 
> $ swift -v -A http://s3.paca.tw:80/auth -U paca:paca1 -K 
> UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA stat
> Auth GET failed: http://s3.paca.tw:80/auth/tokens 405 Method Not Allowed
> 
> ( Because there has no test step on wiki,
>  I follow the Florian's question, and guess the test command is above ?!)
> 
> my radosgw-admin config:
> $ radosgw-admin user info --uid=paca
> { "user_id": "paca",
>   "rados_uid": 0,
>   "display_name": "chuanyu",
>   "email": "chuanyu <at> cs.nctu.edu.tw",
>   "suspended": 0,
>   "subusers": [
>         { "id": "paca:paca1",
>           "permissions": "full-control"}],
I've correct the permissions problem, thanks Florian!
>   "keys": [
>         { "user": "paca",
>           "access_key": "DS932H4EI9HK7I1CTDNF",
>           "secret_key": "Rn\/5FqHzRPZFN6f9R\/LuTqvG0AYjbHtrurrGydVk"}],
>   "swift_keys": [
>         { "user": "paca:paca1",
>           "secret_key": "UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA"}]}
> 
> ceph.conf:
> [client.radosgw.gateway]
>     host = volume
>     keyring = /etc/ceph/keyring/radosgw.gateway.keyring
>     rgw socket path = /var/run/ceph/rgw.sock
>     log file = ""
>     syslog = true
>     debug rgw = 20
> 
> my log:
> http://pastebin.com/rhGhATmv
Hi,

I've noticed that the log shows I'm using *POST* method to getting op?
   req 9:0.000277:swift-auth:POST /auth/tokens::getting op 

But the code shows I'll always get NULL return

/ceph/src/rgw/rgw_swift_auth.cc:239
239 RGWOp *RGWHandler_SWIFT_Auth::get_op()
240 {
241   RGWOp *op;
242   switch (s->op) {
243    case OP_GET:
244      op = &rgw_swift_auth_get;
245      break;
246    default:
247      return NULL;
248   }


So 405 error occurs,
/ceph/src/rgw/rgw_main.cc:273
273   req->log(s, "getting op");
274   op = handler->get_op();
275   if (!op) {
276     abort_early(s, -ERR_METHOD_NOT_ALLOWED);
277     goto done;

My swift version (Version: 1.4.8-0ubuntu2, Ubuntu 12.04)
$ swift --version
swift 1.0

Does the version mismatch, or something else goes wrong?
I'll try curl connection directly later,

Thanks!
Chuanyu Tsai.

> 
> Any advice would be appreciate!
> Tthanks,
> Chuanyu


