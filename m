From: Guang Yang <yguang11@outlook.com>
Subject: EC pool - empty files in OSD from radosgw
Date: Sat, 12 Jul 2014 00:43:56 +0800
Message-ID: <BLU436-SMTP933F4D7E759A69ACAF763ADF090@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s32.hotmail.com ([65.55.111.171]:58090 "EHLO
	BLU004-OMC4S32.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbaGKQoG convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Jul 2014 12:44:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic Dachary <loic@dachary.org>, Ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic,
I opened an issue in terms of a change brought along with EC pool plus radosgw (http://tracker.ceph.com/issues/8625), in our test cluster, we observed a large number of empty files in OSD and the root cause is that for head object from radosgw, there are a couple of transactions coming together, including create 0~0, setxattr, writefull, as EC bring the concept of the object generation, the create transaction will first create an object and the following write full transition will be taken as an update and rename the original empty file to a generation and create/write a new file. As a result, we observed quite some empty files.

There is an bug tracking the effort to remove those files with generation and is pending to be back port to firefly, that could definitely help our use case, however, I am also wondering if there is any room to improve for such case so that those empty files would not be generated in the first place (change might be at radosgw side).

Any suggestion is welcomed.

Thanks,
Guang