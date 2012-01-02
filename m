From: Wido den Hollander <wido@widodh.nl>
Subject: Re: scrubbing
Date: Mon, 02 Jan 2012 12:13:49 +0100
Message-ID: <4F01916D.2080209@widodh.nl>
References: <4F0190B0.7070500@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:60288 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab2ABLNv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jan 2012 06:13:51 -0500
In-Reply-To: <4F0190B0.7070500@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/02/2012 12:10 PM, Jens Rehp=F6hler wrote:
> Happy new year  !!

Let this be a great year for Ceph :-)

>
> another year another question:
>
> I got the following from ceph -w :
>
> 2012-01-02 12:05:17.294350    pg v830384: 1254 pgs: 18 creating, 1235
> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12=
763
> GB / 14887 GB avail
> 2012-01-02 12:05:23.763982    pg v830385: 1254 pgs: 18 creating, 1235
> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12=
763
> GB / 14887 GB avail
> 2012-01-02 12:05:27.295568    pg v830386: 1254 pgs: 18 creating, 1235
> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12=
763
> GB / 14887 GB avail
> 2012-01-02 12:05:28.765457    pg v830387: 1254 pgs: 18 creating, 1235
> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, 12=
763
> GB / 14887 GB avail

Which version are you running?

This was a known bug but should be fixed about two weeks ago in the=20
master branch.

I also encountered this one, but it's resolved for me right now.

Wido

>
> ceph pg dump | grep scrub:
> pg_stat    objects    mip    degr    unf    kb    bytes    log
> disklog    state    v    reported    up    acting    last_scrub
> 34.2    1583    0    0    0    6125554    6272545912    3319    3319
> active+clean+scrubbing    933'385350    926'63653    [3,4]    [3,4]
> 927'337222    2011-12-27 13:20:42.436092
>
> This happens once a week. If i restart ceph i takes a moment an the
> "scrubbing" disappears.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
