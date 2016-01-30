From: Willem Jan Withagen <wjw@digiware.nl>
Subject: compiling stops at od compare
Date: Sat, 30 Jan 2016 14:22:07 +0100
Message-ID: <56ACB8FF.5000605@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43072 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128AbcA3NmD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jan 2016 08:42:03 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id A6405153413
	for <ceph-devel@vger.kernel.org>; Sat, 30 Jan 2016 14:41:59 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id B513C15340A
	for <ceph-devel@vger.kernel.org>; Sat, 30 Jan 2016 14:22:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When trying to compile on CentOS 7, gcc =3D 4.8.3

os/bluestore/BlueFS.cc: In member function =E2=80=98int
BlueFS::_read(BlueFS::FileReader*, BlueFS::FileReaderBuffer*, uint64_t,
size_t, ceph::bufferlist*, char*)=E2=80=99:
os/bluestore/BlueFS.cc:731:31: warning: comparison between signed and
unsigned integer expressions [-Wsign-compare]
     int r =3D MIN((int)len, left);

This MIN is used to determine the amount of buffer that is still left
to be filed.
And here len and left are both size_t..., suggesting that both cannot b=
e
negative. So either both need to be promoted/cast, or neither.

The cast (int)len suggests that len could be negative.
The part where that could happen is at line 750:

   off +=3D r;
    len -=3D r;
    ret +=3D r;

So there the loop exit needs len to be exactly equal to r. Even if the
loop specifies while(len>0). if len gets "negative" it grows into
something rather big.

Now if len never gets negative then it also does not need to get cast t=
o
int. If it does, then in the unsigned case it will always be larger tha=
n
left.

So bottomline is that the cast serves no purpose?
Removing it fixes compilation.

--WjW

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
