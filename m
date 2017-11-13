From: John Spray <jspray@redhat.com>
Subject: Re: SMART disk monitoring
Date: Mon, 13 Nov 2017 10:46:25 +0000
Message-ID: <CALe9h7eU_UiU93AUgJ4819Q2So5V=Nabjmz7ViHcJioXngknQA@mail.gmail.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com> <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:54157 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdKMKqr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 05:46:47 -0500
Received: by mail-wr0-f176.google.com with SMTP id u40so13991791wrf.10
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 02:46:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Lars Marowsky-Bree <lmb@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Nov 12, 2017 at 8:16 PM, Sage Weil <sage@newdream.net> wrote:
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
>>
>> Would the goal be for them to report this to ceph-mgr, or expose
>> directly as something to be queried via, say, a prometheus exporter
>> binding? Or are the OSDs supposed to directly act on this information?
>
> The OSD is just a convenient channel, but needn't be the only
> one or only option.
>
> Part 1 of the project is to get JSON output out of smartctl so we avoid
> one of the many crufty projects floating around to parse its weird output;
> that'll be helpful all consumers, presumably.
>
> Part 2 is to map OSDs to host:device pairs; that merged already.
>
> Part 3 is to gather the actual data.  The prototype has the OSD polling
> this because it (1) knows which devices it consumes and (2) is present on
> every node.  We're contemplating a per-host ceph-volume-agent for
> assisting with OSD (de)provisioning (i.e., running ceph-volume); that
> could be an option.  Of if some other tool is already scraping it and can
> be queried, that would work too.
>
> I think the OSD will end up being a necessary path (perhaps among many),
> though, because when we are using SPDK I don't think we'll be able to get
> the SMART data via smartctl (or any other tool) at all because the OSD
> process will be running the NVMe driver.
>
> Part 4 is to archive the results.  The original thought was to dump it
> into RADOS.  I hadn't considered prometheus, but that might be a better
> fit!  I'm generally pretty cautious about introducing dependencies like
> this but we're already expecting prometheus to be used for other metrics
> for the dashboard.  I'm not sure whether prometheus' query interface lends
> itself to the failure models, though...

At the risk of stretching the analogy to breaking point, when we build
something "batteries included", it doesn't mean someone can't also
plug it into a mains power supply :-)

My attitude to prometheus is that we should use it (a lot! I'm a total
fan boy) but that it isn't an exclusive relationship: plug prometheus
into Ceph and you get the histories of things, but without prometheus
you should still be able to see all the latest values.

In that context, I would wonder if it would be better to initially do
the SMART work with just latest values (for just latest vals we could
persist these in config keys), and any history-based failure
prediction would perhaps depend on the user having a prometheus server
to store the history?

John

> Part 5 is to do some basic failure prediction!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
