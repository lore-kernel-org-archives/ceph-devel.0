From: Wido den Hollander <wido@widodh.nl>
Subject: Re:
Date: Tue, 23 Oct 2012 13:50:09 +0200
Message-ID: <50868471.1070105@widodh.nl>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60783 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab2JWLuL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 07:50:11 -0400
In-Reply-To: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jie sun <0maidou0@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/23/2012 06:12 AM, jie sun wrote:
> Hi,
>
> I created and mounted a rbd for a virtual machine. And it can be used
> as a block device normally, but often prompt some log like below:

Could you provide us a bit more information?

What kernel are you using?

What does "ceph -s" show you?

Are you running KVM virtual machines and connecting /dev/rbd0 as a 
device to the virtual machine?

Wido

> "Oct 23 10:30:22 ubuntu12 kernel: [321506.941606] libceph: osd3
> 10.100.211.146:6810 socket closed
> Oct 23 10:30:59 ubuntu12 kernel: [321544.337856] libceph: osd9
> 10.100.211.68:6809 socket closed
> Oct 23 10:45:22 ubuntu12 kernel: [322407.233090] libceph: osd3
> 10.100.211.146:6810 socket closed
> Oct 23 10:45:59 ubuntu12 kernel: [322444.766796] libceph: osd9
> 10.100.211.68:6809 socket closed
> Oct 23 11:00:22 ubuntu12 kernel: [323307.529098] libceph: osd3
> 10.100.211.146:6810 socket closed
> Oct 23 11:01:00 ubuntu12 kernel: [323345.241679] libceph: osd9
> 10.100.211.68:6809 socket closed
> Oct 23 11:15:22 ubuntu12 kernel: [324207.821113] libceph: osd3
> 10.100.211.146:6810 socket closed
> Oct 23 11:16:00 ubuntu12 kernel: [324245.717747] libceph: osd9
> 10.100.211.68:6809 socket closed
> Oct 23 11:17:01 ubuntu12 CRON[10529]: (root) CMD (   cd / && run-parts
> --report /etc/cron.hourly)
> Oct 23 11:30:23 ubuntu12 kernel: [325108.117134] libceph: osd3
> 10.100.211.146:6810 socket closed"
>
> These log also can be found in "/var/log/syslog".
> I google something about this problem,but didn't understand what
> you've wrote in "http://tracker.newdream.net/issues/2260" exactly.
> How can I resolve this problem? My ceph version is 0.48.
> Should I change some files, or modify some content of some file?
>
> Thank you !
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

