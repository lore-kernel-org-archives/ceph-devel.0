From: Jens Rehpoehler <jens.rehpoehler@filoo.de>
Subject: Re: Re: Problem with inconsistent PG
Date: Sun, 12 Feb 2012 13:00:53 +0100
Message-ID: <4F37A9F5.6030908@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:34887 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab2BLMA4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Feb 2012 07:00:56 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@newdream.net

>>  Hi Liste,
>>
>>  today i've got another problem.
>>
>>  ceph -w shows up with an inconsistent PG over night:
>>
>>  2012-02-10 08:38:48.701775    pg v441251: 1982 pgs: 1981 active+clean, 1
>>  active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
>>  GB avail
>>  2012-02-10 08:38:49.702789    pg v441252: 1982 pgs: 1981 active+clean, 1
>>  active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
>>  GB avail
>>
>>  I've identified it with "ceph pg dump - | grep inconsistent
>>
>>  109.6    141    0    0    0    463820288    111780    111780
>>  active+clean+inconsistent    485'7115    480'7301    [3  <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#3>,4  <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#4>]    [3  <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#3>,4  <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#4>]
>>  485'7061    2012-02-10 08:02:12.043986
>>
>>  Now I've tried to repair it with: ceph pg repair 109.6
>>
>>  2012-02-10 08:35:52.276325 mon<- [pg,repair,109.6]
>>  2012-02-10 08:35:52.276776 mon.1 ->  'instructing pg 109.6 on osd.3 to
>>  repair' (0)
>>
>>  but i only get the following result:
>>
>>  2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455420 osd.3
>>  10.10.10.8:6801/25980 6913 : [ERR] 109.6 osd.4: soid
>>  1ef398ce/rb.0.0.0000000000bd/headsize 2736128 != known size 3145728
>>  2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455426 osd.3
>>  10.10.10.8:6801/25980 6914 : [ERR] 109.6 scrub 0 missing, 1 inconsistent
>>  objects
>>  2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455799 osd.3
>>  10.10.10.8:6801/25980 6915 : [ERR] 109.6 scrub 1 errors
>>
>>  Can someone please explain me what to do in this case and how to recover
>>  the pg ?
>
>So the "fix" is just to truncate the file to the expected size, 3145728,
>by finding it in the current/ directory.  The name/path will be slightly
>weird; look for 'rb.0.0.0000000000bd'.
>
>The data is still suspect, though.  Did the ceph-osd restart or crash
>recently?  I would do that, repair (it should succeed), and then fsck the
>file system in that rbd image.
>
>We just fixed a bug that was causing transactions to leak across
>checkpoint/snapshot boundaries.  That could be responsible for causing all
>sorts of subtle corruptions, including this one.  It'll be included in
>v0.42 (out next week).
>
>sage

Hi Sarge,

no ... the osd didn't crash. I had to do some hardware maintainance and push it
out of distribution with "ceph osd out 3". After a short while i used "/etc/init.d/ceph stop" on that osd.
Then, after my work i've started ceph and push it in the distribution with "ceph osd in 3".

Could you please tell me if this is the right way to get an osd out for maintainance ? Is there
any other thing i should do to keep data consistent ?

My structure is ->  3 MDS/MON Server on seperate Hardware Nodes an 3 OSD Nodes with a each a total capacity
of 8 TB. Journaling is done on a separate SSD per node. The whole thing is a data store for a kvm virtualisation
farm. The farm is accessing the data directly per rbd.

Thank you

Jens




