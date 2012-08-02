From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Documentation and Versions
Date: Wed, 01 Aug 2012 17:34:45 -0700
Message-ID: <5019CB25.6060405@inktank.com>
References: <CA+jddaM3S1-H7ZsDBLu94Sd_NsEkOJJCDKSTNk47UhQ1tg7vqw@mail.gmail.com> <50196388.5020805@inktank.com> <CA+jddaP4OGoA6bVC_ciJv_sob_V3g_PbtzWuUpiWJR0HZUaJNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36924 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2HBAes (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 20:34:48 -0400
Received: by ghrr11 with SMTP id r11so1551778ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 17:34:48 -0700 (PDT)
In-Reply-To: <CA+jddaP4OGoA6bVC_ciJv_sob_V3g_PbtzWuUpiWJR0HZUaJNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 08/01/2012 11:53 AM, Mandell Degerness wrote:
> Thank you.
>
> I'd like to make two additional, related requests:
>
> 1) The internal ceph --help output should include the new command options

Yeah, the help output could certainly be improved. The client tool
needs to talk to the monitors to determine what basic commands are
available, but it would help to give each subsystem a "help" command
that queried them as necessary to report available commands.

Some commands (like ceph osd tell ...) are implemented on the osds,
so the available subcommands could vary if osd versions differed, but
it's still possible to provide usage info for a given osd.

I've opened http://www.tracker.newdream.net/issues/2894 for this.

> 2) The internal error information should be better written.  Right
> now, "ceph osd crush set ..." seems to work (on 0.48).  If, however,
> you type "ceph osd crush get" (i.e. trying to see what other options
> work), you get the result "unknown command crush" which implies to me
> that none of the crush subcommands are implemented, rather than that
> the "get" subcommand is not implemented.

Yeah, the command processing could be a lot better.
I created http://www.tracker.newdream.net/issues/2895 for this
particular error.

Josh

> Regards,
> Mandell Degerness
>
> On Wed, Aug 1, 2012 at 10:12 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 07/31/2012 03:10 PM, Mandell Degerness wrote:
>>>
>>> I was looking through the latest documentation on ceph.com and I
>>> really like some of the new ways of doing things.  What I find
>>> confusing, however, is the lack of documentation as to what version of
>>> ceph you need to be running in order to use the commands.  In
>>> particular, what is the required version of ceph to run the "ceph osd
>>> crush ..." commands?
>>
>>
>> Yeah, there should probably be versions in the docs. The 'ceph osd crush'
>> commands were added in 0.46, but there are bug fixes for
>> 'ceph osd crush set' in 0.48 and 'ceph osd crush move' in 0.49.
>>
>>> Regards,
>>> Mandell Degerness
>>
>>

