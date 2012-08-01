From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: Documentation and Versions
Date: Wed, 1 Aug 2012 11:53:46 -0700
Message-ID: <CA+jddaP4OGoA6bVC_ciJv_sob_V3g_PbtzWuUpiWJR0HZUaJNw@mail.gmail.com>
References: <CA+jddaM3S1-H7ZsDBLu94Sd_NsEkOJJCDKSTNk47UhQ1tg7vqw@mail.gmail.com>
	<50196388.5020805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64540 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2HASxt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 14:53:49 -0400
Received: by vcbfk26 with SMTP id fk26so7373578vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 11:53:47 -0700 (PDT)
In-Reply-To: <50196388.5020805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thank you.

I'd like to make two additional, related requests:

1) The internal ceph --help output should include the new command options
2) The internal error information should be better written.  Right
now, "ceph osd crush set ..." seems to work (on 0.48).  If, however,
you type "ceph osd crush get" (i.e. trying to see what other options
work), you get the result "unknown command crush" which implies to me
that none of the crush subcommands are implemented, rather than that
the "get" subcommand is not implemented.

Regards,
Mandell Degerness

On Wed, Aug 1, 2012 at 10:12 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 07/31/2012 03:10 PM, Mandell Degerness wrote:
>>
>> I was looking through the latest documentation on ceph.com and I
>> really like some of the new ways of doing things.  What I find
>> confusing, however, is the lack of documentation as to what version of
>> ceph you need to be running in order to use the commands.  In
>> particular, what is the required version of ceph to run the "ceph osd
>> crush ..." commands?
>
>
> Yeah, there should probably be versions in the docs. The 'ceph osd crush'
> commands were added in 0.46, but there are bug fixes for
> 'ceph osd crush set' in 0.48 and 'ceph osd crush move' in 0.49.
>
>> Regards,
>> Mandell Degerness
>
>
