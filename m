From: Xinze Chi <xmdxcxz@gmail.com>
Subject: Re: scubbing for a long time and not finished
Date: Thu, 19 Mar 2015 15:30:18 +0800
Message-ID: <CANE=7sWbh9aJHp603BuFZivtLJ5a-axDq7CyHCfwaDWMRw7wAg@mail.gmail.com>
References: <CANE=7sWwheXa3WZb_+b3G57MBuhcdMssJJqVjR9y9yRHu6vFEQ@mail.gmail.com>
	<da34275f64ad3e2960322516f488fd@ip-10-0-3-214>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32838 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbbCSHaT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 03:30:19 -0400
Received: by obcxo2 with SMTP id xo2so48572971obc.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 00:30:19 -0700 (PDT)
In-Reply-To: <da34275f64ad3e2960322516f488fd@ip-10-0-3-214>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Currently, users do not know  when some pg do scrubbing for a long time=
=2E
I think whether we could give some warming if it happend (defined as
osd_scrub_max_time).
It would tell the user something may be wrong in cluster.


2015-03-17 21:21 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail.c=
om>:
>
> On =E5=91=A8=E4=BA=8C, 3=E6=9C=88 17, 2015 at 10:01 =E4=B8=8A=E5=8D=88=
, Xinze Chi <xmdxcxz@gmail.com> wrote:
>
> hi,all:
>
>     I find a pg on my test cluster in doing scrubbing for a long time
> and not finish. there are not some useful scrubbing log. scrubs_activ=
e
> is 1, so inc_scrubs_pending return false. I think the reason is that
> some scrub message is lost, so primary can not continue chunky_scrub =
,
> so it hang up at scrubbing.
>
>    Could anyone give some suggestion?
>
>    Thanks
>
>
> [root@ceph0 ~]# date
> Tue Mar 17 09:54:54 CST 2015
> [root@ceph0 ~]# ceph pg dump | grep scrub
> dumped all in format plain
> pg_stat objects mip degr misp unf bytes log disklog state state_stamp
> v reported up up_primary acting acting_primary last_scrub
> scrub_stamplast_deep_scrub deep_scrub_stamp
> 1.97 30 0 0 0 0 117702656 31 31 active+clean+scrubbing 2015-03-16
> 14:50:02.110796 78'31 78:50 [9,6,1] 9 [9,6,1] 9 0'0 2015-03-15
> 14:49:33.661597 0'0 2015-03-13 14:48:53.341679
>
>    The attachment is the log from primary, the scrubbing pg is 1.97s0=
=2E
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
