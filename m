From: Andrey Korolyov <andrey@xdel.ru>
Subject: 0.55 crashed during upgrade to bobtail
Date: Tue, 1 Jan 2013 20:49:58 +0300
Message-ID: <CABYiri_pJynyL2DSRqErkAYp0H0sDmwg0HCAYfB84JUZ2dfczw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0447a05d5b0d0304d23dc398
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52168 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3AARuW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jan 2013 12:50:22 -0500
Received: by mail-ob0-f177.google.com with SMTP id uo13so12118578obb.22
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jan 2013 09:50:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

--f46d0447a05d5b0d0304d23dc398
Content-Type: text/plain; charset=UTF-8

Hi,

All osds in the dev cluster died shortly after upgrade (packet-only,
i.e. binary upgrade, even without restart running processes), please
see attached file.

Was: 0.55.1-356-g850d1d5
Upgraded to: 0.56 tag

The only one difference is a version of the gcc corresponding
libstdc++ - 4.6 on the buildhost and 4.7 on the cluster. Of course I
may do a rollback and problem will eliminate with high probability,
but seems there should be some fix. Also I have something simular in
the the testing env days ago -  packet upgrade inside 0.55 killed all
_windows_ guests_ and one of tens of linux guests running above rbd.
Unfortunately I have no debug sessions at this moment and I have only
tail of the log from qemu:

terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
  what():  buffer::end_of_buffer

I`m blaming ldconfig action from librbd because nothing else `ll cause
such case of destroy on the running processes - may be I`m wrong.

thanks!

WBR, Andrey

--f46d0447a05d5b0d0304d23dc398
Content-Type: application/x-gzip; name="crashes-2013-01-01.tgz"
Content-Disposition: attachment; filename="crashes-2013-01-01.tgz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbfbzx220

H4sIAHYh41AAA+1Yy47iRhRlzVfciEV6NI1db9sonVE0m2wiZRFly5TLZbAGXKjKdPdkkW9PGTwt
P4BJJgxRKz5qMPjU49a5Vb6nUVa6tXZzgjCdI+z/wsm1gTwizusrjjg6fMeMHa4NJpigCAmCOKcT
HwpGdAL86pGcwN5V0gJMnjO92Wh7oZ227hYB3RZqmH8cVM/VNeeoEyyO+T6Vfxph3ss/Q5hMAF0z
iHP4n+f/t3XhYG1cBZnRDkpTwVo+algpNWeBgKL0+nhhsnuQZQamWmsL1ZPxrVwwnT5JWxblagHv
jbX7XaUzcGtp/WVTpFbaT/7qqgWgZwTfPfgLzwWPmOBC+RejeOo7aniSDla61FbWI6Sf4EO4dzZM
izJUereeG5fBvAAE8/muyOZ5sdEQPkob2v2xRehbBCjwJMwVhLpSx9v1W6BM+X0w/dWalZVbqLTd
FuVhoqeiWoMrVqXcgLiHn1Jj/e1gOkNQR1w/tnIhdRoplkap1wLevYO7N9MZ/swfETOFo6TmU+kK
tSyMg7vKK/uAnusRsjzG2L+9AVnBYWVFqTb7TIfq7duQBZFfaeXCl87BesE4m84INAP6/FjtY79b
Ll3qB40Tdg/NBBhLybFG97BcFuVSre3q4Qezq4pt8Ydfo9lXP9bUY1Utd9Ju+9z5mJpJFzGdziiA
17bWfflki0rDnRc1PznWamNSuQmb5oFSC8GnM9ZRVNIojpOspSjv8yJJRIsXQ17RFh8N+FTrFh/3
MpbjjMuaX/6yzAq3M07X6sqHIAhepPV5RRn5W1nzWvlz4BNHaDSdJQB/tu+/7AaR5zGnF1L1zybj
VPjNiOB3/2wqTPmzMR8XC+XPazPhYB8os936c3xcpbQrd/zkyfrDYfK6iSlDmflTsnRGfdRVnUSG
66lwV+UYYYHa54K0+HrXE647PO3zAnd41udj3uF5L8s5wUmbF/3+CYnbfNTZBYdChNt83O8fdeNL
LvMEDeLvrJ/09ItUJHibH+jHZDt+MtBP08747PL6CB/Epzr9B/qJTn5J9AV+oF83fyTp50+SNk8H
+nXXR/Fg/LTDk8vrp3TAow4/2H/d9dH+/lMpaj/F6EC/bv7pQL+IdfiBfr31J8P4W/xX1P8T/o/c
2P8RjkXj/zD3DY7+j4/+7xa4rYHDlw0c/hYGLpIx48m/MXCRjGKur2rgBM/Ji83IkUaUvR4D5xWl
mJ03cEf+vIH7zJ8zcA0/GrhvauCOKqcsP2PgjrueZOcM3KE/7xtA1u/P8zMGruFFxwC0DFzDx93x
o178fQMYt/hmq3T4YQEl7edCy8A18zN50sBdrQD/xzhR/+mN67+/SV7qPyXoUP/R+PvPTfCVRTXz
/2DjJO0U1feyrH8+kkpp52Crt8a7B/88kllm6zt1Kc2okFjHGY9f4VkZMWLEiBEjRowYMWLEiBEj
Rox4jfgLaU9YBgAoAAA=
--f46d0447a05d5b0d0304d23dc398--
