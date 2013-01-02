From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph logging level
Date: Wed, 2 Jan 2013 17:57:14 +0100
Message-ID: <CAOLwVUndvK3iXKSmW+yWVSZZJWYBDrMuLj1rhVmSfTsQ9Xo0xg@mail.gmail.com>
References: <CAOLwVU=sxV3U81b3j-r-2=sEruFkOryhv46toPeRgT1Pqj19Xw@mail.gmail.com>
 <alpine.DEB.2.00.1301020824230.11884@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:40479 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab3ABQ5g convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 11:57:36 -0500
Received: by mail-la0-f50.google.com with SMTP id fs13so6431868lab.37
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 08:57:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301020824230.11884@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

Thanks for your answer.

> LOG_USER is currently hard-coded.  It would be pretty easy to make th=
is
> configurable... LOG_DAEMON may also be a better default choice.

LOG_DAEMON will be a better choice and even better using a different
facility to isolate ceph logs from other services that log into
LOG_DAEMON. Using LOCAL0, LOCAL1 and so on for example.

> We can just add a min log level configurable.

Please :-)

New config options like:

* log_facility
* log_level

will be a good starting point I guess.

Thanks!
--
Regards,
S=E9bastien Han.


On Wed, Jan 2, 2013 at 5:28 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 2 Jan 2013, S?bastien Han wrote:
>> Hi all,
>>
>> I've been struggling with Ceph logging.
>>
>> As far as I saw we can log to syslog but we can't specify any
>> facility. So my question is: which facility does ceph use by default=
?
>
> LOG_USER is currently hard-coded.  It would be pretty easy to make th=
is
> configurable... LOG_DAEMON may also be a better default choice.
>
>> Second thing is, I'm sick of all those "log [INF]" messages from the
>> ceph-mon, like:
>>
>> Jan  2 13:27:07 ceph02 ceph-mon: 2013-01-02 13:27:07.749511
>> 7f227b2fa700  0 log [INF] : pgmap v74529: 80 pgs: 80 active+clean;
>> 9753 MB data, 17012 MB used, 383 GB / 399 GB avail
>>
>> Is there a way to disable them? Which level is that? INFO? DEBUG?
>>
>> Ideally I'd like to disable all INFO logs, I only want to see ERROR =
logs.
>
> Not currently.  This would be very simple to add.  See mon/LogMonitor=
=2Ecc:
>
>       if (g_conf->mon_cluster_log_to_syslog) {
>         syslog(clog_type_to_syslog_prio(le.type) | LOG_USER, "%s", s.=
c_str());
>       }
>
> We can just add a min log level configurable.
>
> Opened #3704.
>
> sage
>
>
>
>>
>> Thanks you in advance :-)
>>
>> --
>> Regards,
>> S?bastien Han.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
