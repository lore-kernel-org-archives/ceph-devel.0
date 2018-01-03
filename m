From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: SMART disk monitoring
Date: Wed, 3 Jan 2018 09:28:54 -0800
Message-ID: <CAFMfnwqnknmuWnHZWY1K5Tzi1f=PF+mzXoYBx21AHKvvAR5THQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com> <alpine.DEB.2.11.1801031632370.8186@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:41122 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeACR24 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jan 2018 12:28:56 -0500
Received: by mail-yw0-f178.google.com with SMTP id f1so803920ywd.8
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jan 2018 09:28:55 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801031632370.8186@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Lars Marowsky-Bree <lmb@suse.com>, yaarit@gmail.com, ceph-devel@vger.kernel.org

I seem to recall a batch of hardware in one of the early clusters that
had issues with repeated polling of smart data, IO would pause for a
few seconds. This might explain why they are writing out a daily cron
script and polling a results file instead of repeatedly polling the
actual devices.

On Wed, Jan 3, 2018 at 8:37 AM, Sage Weil <sage@newdream.net> wrote:
> On Sun, 12 Nov 2017, Lars Marowsky-Bree wrote:
>> On 2017-11-10T22:36:46, Yaarit Hatuka <yaarit@gmail.com> wrote:
>>
>> > Many thanks! I'm very excited to join Ceph's outstanding community!
>> > I'm looking forward to working on this challenging project, and I'm
>> > very grateful for the opportunity to be guided by Sage.
>>
>> That's all excellent news!
>>
>> Can we discuss though if/how this belongs into ceph-osd? Given that this
>> can (and is) already collected via smartmon, either via prometheus or, I
>> assume, collectd as well? Does this really need to be added to the OSD
>> code?
>
> Hi Lars,
>
> Yaarit is taking a look at this now and the smartmon.sh collector for
> prometheus looks a bit janky:
>
> 1) It seems like you have to set up a cron job to write the current smart
> output to a text file in a directory somewhere, and then prometheus will
> scrape it when polled.[1]
>
> 2) smartmon.sh[2] is a shortish pile of bash that collects only a handful
> of fields by parsing smartctl output.
>
> The second piece will hopefully improve once the JSON output mode for
> smartctl is completed (that is in progress upstream in smartmontools).
> But the first part seems awkward, and doesn't look like it would work out
> of the box.  Are you guys currently collecting SMART data?  If so, how did
> you automate/simplify the setup?
>
> Thanks!
> sage
>
>
> [1] https://github.com/prometheus/node_exporter#textfile-collector
> [2] https://github.com/prometheus/node_exporter/edit/master/text_collector_examples/smartmon.sh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
