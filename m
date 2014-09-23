From: Zhao zhiming <zhaozhiming003@gmail.com>
Subject: rgw doc CONFIGURING PRINT CONTINUE
Date: Tue, 23 Sep 2014 15:37:09 +0800
Message-ID: <96EBC28B-921D-4E64-9C4E-E890AD6483D3@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:63773 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaIWHhX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Sep 2014 03:37:23 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so5966862pdj.4
        for <ceph-devel@vger.kernel.org>; Tue, 23 Sep 2014 00:37:22 -0700 (PDT)
Received: from [172.31.204.80] ([119.122.19.56])
        by mx.google.com with ESMTPSA id ds14sm11285541pdb.20.2014.09.23.00.37.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 00:37:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

HI ALL,

I saw the ceph radios gateway doc (http://ceph.com/docs/master/radosgw/=
config/#configuring-print-continue) say: =20

"On CentOS/RHEL distributions, turn off print continue. If you have it =
set to true, you may encounter problems with PUT operations.:

But when I set this config item to false, I put object failed with 400 =
error.=20
And I set the =93row print continue =3D true=94, it make put object suc=
cess.

My question is, it=92s something wrong with the rgw doc about print con=
tinue config?=20

I use s3 java api to upload object, and my system info is: Redhat  Ente=
rprise 6.5, ceph 0.80.5.

thanks.--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
