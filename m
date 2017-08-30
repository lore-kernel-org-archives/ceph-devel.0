From: Two Spirit <twospirit6905@gmail.com>
Subject: Memory. 100TB OSD?
Date: Wed, 30 Aug 2017 10:30:13 -0700
Message-ID: <CAKRxpuv33KwzAjCu57OjFUVLCY2+t2iHT9mURitXbs1qJOM3DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:38808 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdH3RaP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 13:30:15 -0400
Received: by mail-io0-f180.google.com with SMTP id 81so7749509ioj.5
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 10:30:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've been seeing luminous OSD spit out error messages about out of
memory even tho I was within the minimum memory requirements
documented. 2GB with 2TB. I've also tested with 1.5TB, 1TB, and 500GB
configurations.

I've got 100TB single chassis file servers in production. Does this
mean that to run an OSD on them I need 100GB RAM?

And am I supose to run 1 daemon per 10T disk or since I've go the
disks in a RAID, can I run 1 daemon for the whole of the 100TB
RAID?<div id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
<table style="border-top: 1px solid #D3D4DE;">
	<tr>
        <td style="width: 55px; padding-top: 13px;"><a
href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
target="_blank"><img
src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
alt="" width="46" height="29" style="width: 46px; height: 29px;"
/></a></td>
		<td style="width: 470px; padding-top: 12px; color: #41424e;
font-size: 13px; font-family: Arial, Helvetica, sans-serif;
line-height: 18px;">Virus-free. <a
href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
target="_blank" style="color: #4453ea;">www.avg.com</a>
		</td>
	</tr>
</table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
height="1"></a></div>
