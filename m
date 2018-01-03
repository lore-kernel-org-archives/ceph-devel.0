From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: SMART disk monitoring
Date: Wed, 3 Jan 2018 21:36:56 +0100
Message-ID: <20180103203501.kvmekeaq2ya6w3u3@jf_suse_laptop>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com>
 <alpine.DEB.2.11.1801031632370.8186@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38233 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeACUhR (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 3 Jan 2018 15:37:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1801031632370.8186@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Lars Marowsky-Bree <lmb@suse.com>, yaarit@gmail.com, ceph-devel@vger.kernel.org

On Wed, Jan 03, 2018 at 04:37:00PM +0000, Sage Weil wrote:
>On Sun, 12 Nov 2017, Lars Marowsky-Bree wrote:
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
>Hi Lars,
>
>Yaarit is taking a look at this now and the smartmon.sh collector for
>prometheus looks a bit janky:
>
>1) It seems like you have to set up a cron job to write the current smart
>output to a text file in a directory somewhere, and then prometheus will
>scrape it when polled.[1]
>
>2) smartmon.sh[2] is a shortish pile of bash that collects only a handful
>of fields by parsing smartctl output.
>
>The second piece will hopefully improve once the JSON output mode for
>smartctl is completed (that is in progress upstream in smartmontools).
>But the first part seems awkward, and doesn't look like it would work out
>of the box.  Are you guys currently collecting SMART data?  If so, how did
>you automate/simplify the setup?
We do collect SMART data with the mechanism described above. We use salt to 
setup up a cronjob (though say a systemd timer would also work) that runs
smartmon.sh > node_exporter/text_collector_dir/file.
It does not work out of the box, but that is how the node_exporter is meant to 
be extended afaiu.
>
>Thanks!
>sage
>
>
>[1] https://github.com/prometheus/node_exporter#textfile-collector
>[2] https://github.com/prometheus/node_exporter/edit/master/text_collector_examples/smartmon.sh
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
