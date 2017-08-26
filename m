From: Two Spirit <twospirit6905@gmail.com>
Subject: feature request to "ceph osd status"
Date: Sat, 26 Aug 2017 11:07:42 -0700
Message-ID: <CAKRxpuuGOHvvrkg+XkDo3jWnbr2o4eObru5yBEuChyJpD=e=ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:37663 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdHZSHn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Aug 2017 14:07:43 -0400
Received: by mail-io0-f172.google.com with SMTP id d81so5971052ioj.4
        for <ceph-devel@vger.kernel.org>; Sat, 26 Aug 2017 11:07:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. I found this command by accident. it doesn't seem to be undocumented.

ceph osd status

There is a very similiar command "ceph osd stat" with different info

The status command is very useful command and I'd like to see it stay
around even tho it seems to be an undocumented command.

It would be nice to have a 3rd column "total" which is used+avail
columns and then another row at the bottom subtotaling the "used",
"avail", and "total" columns.

I know all these could be be calculated, but with more OSDs, it is
convenient to have it all available at a glance<div
id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
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
