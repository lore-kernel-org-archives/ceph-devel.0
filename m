From: John Spray <jspray@redhat.com>
Subject: Re: feature request to "ceph osd status"
Date: Wed, 30 Aug 2017 16:38:00 +0100
Message-ID: <CALe9h7ejjAHOQ+v2rxkD3xJMd75tNE-fWkGaBtXqkiP7TSB8-g@mail.gmail.com>
References: <CAKRxpuuGOHvvrkg+XkDo3jWnbr2o4eObru5yBEuChyJpD=e=ew@mail.gmail.com>
 <CALe9h7c-zu=nSARjS1kf8xEqde_bg0FaRkqF8e-Zo=zn8MrBUg@mail.gmail.com>
 <CAKRxpuuS+9ZpE-LagAg6HG01gcCf0XwXxLWBAMOhO3OPUuThDQ@mail.gmail.com>
 <CAKRxpuuDuEDtkuCkuBUYi-mhteLEOznWE5uhw7Qr5kTykT1zyA@mail.gmail.com>
 <alpine.DEB.2.11.1708301326300.20435@piezo.novalocal> <CAKRxpuuBO+VgWTDvMTjh1Lw0S7Zg0QKg9NVdyc+twO+nHmxS3Q@mail.gmail.com>
 <alpine.DEB.2.11.1708301520080.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35303 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdH3PiW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 11:38:22 -0400
Received: by mail-wr0-f171.google.com with SMTP id j29so18663137wre.2
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 08:38:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708301520080.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Two Spirit <twospirit6905@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 30, 2017 at 4:20 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 30 Aug 2017, Two Spirit wrote:
>> the two outputs I was referring to was  "ceph pg dump" vs "ceph osd
>> status". These don't match. I'm guessing it is the osd status that
>> must have the wrong info.
>
> Mine seems okay too?  (Although it's off by 10%.. not sure about that
> part... but not by a factor of 1024)

I think the point is that they're being divided by base 10 k/m/g
factors -- this is just inconsistent between the existing CLI and some
of the new python bits.  We should probably just update it all to be
base 2.

John

>
> $ ceph osd status
> +----+------+-------+-------+--------+---------+--------+---------+
> | id | host |  used | avail | wr ops | wr data | rd ops | rd data |
> +----+------+-------+-------+--------+---------+--------+---------+
> | 0  |      |  294G |  105G |    0   |     0   |    0   |     0   |
> +----+------+-------+-------+--------+---------+--------+---------+
>
> sage
>
>>
>> *never* is too strong of a word. When standard interfaces exist eg
>> JSON/XML that is a luxury. From IT perspective where we use tools from
>> many vendors, most of the time we don't get that luxury. I use to work
>> for a well known unix operating system company prior to the invention
>> of JSON and XML and automated the gui testing. Now that was a pure
>> waste of time keeping up with the graphical changes, so I've been
>> scripting against plaintext for a couple decades now. When I need, I
>> place a "compatibility layer" using regex/wrappers/pipes in between
>> the tool output and my tool which reformats and normalizes the
>> plaintext output to an older version of the output. All this was done
>> through single line lookup table or in the rare case of extreme
>> changes, a call to a external script filter(still effectively one
>> line). The test harness automatically cascaded these through pipes
>> allowing basically any version of the output to be represented. This
>> allowed all old test tools to keep running with no changes as
>> developers kept changing the text interface. It is great that Ceph
>> provide the JSON/XML interfaces tho. Helps a lot.
>>
>> On Wed, Aug 30, 2017 at 6:52 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Tue, 29 Aug 2017, Two Spirit wrote:
>> >> I found "ceph pg dump" also gives the same OSD disk usage information.
>> >> It has summary row, as well as 3 columns.
>> >> The bad thing is that the numbers in ceph pg dump and ceph osd status
>> >> do not match. I'm guessing someone isn't dividing by 1024.
>> >> I think for consistency the PG stuff should go under ceph pg, and OSD
>> >> info go under ceph osd.
>> >
>> > On my test box it matches (current master):
>> >
>> > OSD_STAT USED AVAIL TOTAL HB_PEERS PG_SUM PRIMARY_PG_SUM
>> > 0        274G 98.4G  372G       []      0              0
>> >
>> > vs
>> >
>> > $ df -h .
>> > Filesystem      Size  Used Avail Use% Mounted on
>> > /dev/nvme0n1    373G  274G   99G  74% /nvm
>> >
>> >> As an IT person, I like to to write perl scripts around the outputs,
>> >> and so persistence of the output format is desired
>> >
>> > FWIW you should *never* script against the plaintext output, as it is more
>> > like to change (for readability or other reasons... e.g., changing a raw
>> > byte count to something like "98.4G").  Use the structured JSON or XML
>> > output with -f json[-pretty] or -f xml[-pretty].
>> >
>> > sage
>> >
>> >
>> >>
>> >> On Tue, Aug 29, 2017 at 2:50 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>> >> > I agree the information is redundant, but when I'm trying to figure
>> >> > out what is going on, it is very nice to have all info right in front
>> >> > of my face instead of uber bare bones. Running 'df -kh' shows  [Total]
>> >> > Size, Used, Avail and Use%. That is one step past redundant, but it is
>> >> > aweful nice to see whatever information I want quickly as well as in a
>> >> > familiar format and bit of info I think unix it guys are use to. I can
>> >> > pick the columns of information I need based on what I'm trying to
>> >> > debug. just my two bits on a feature request.
>> >> >
>> >> > On Mon, Aug 28, 2017 at 5:01 AM, John Spray <jspray@redhat.com> wrote:
>> >> >> On Sat, Aug 26, 2017 at 7:07 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>> >> >>> Hi. I found this command by accident. it doesn't seem to be undocumented.
>> >> >>>
>> >> >>> ceph osd status
>> >> >>>
>> >> >>> There is a very similiar command "ceph osd stat" with different info
>> >> >>>
>> >> >>> The status command is very useful command and I'd like to see it stay
>> >> >>> around even tho it seems to be an undocumented command.
>> >> >>>
>> >> >>> It would be nice to have a 3rd column "total" which is used+avail
>> >> >>> columns and then another row at the bottom subtotaling the "used",
>> >> >>> "avail", and "total" columns.
>> >> >>
>> >> >> I prefer to pick two of avail/used/total, rather than printing all
>> >> >> three -- otherwise the information is a bit redundant.
>> >> >>
>> >> >> Putting some totals at the bottom is an interesting idea though.  The
>> >> >> "osd status" and "fs status" commands are implemented in a python
>> >> >> module[1], so anyone who knows a little python could add that.
>> >> >>
>> >> >> John
>> >> >>
>> >> >> 1. https://github.com/ceph/ceph/blob/master/src/pybind/mgr/status/module.py
>> >> >>
>> >> >>>
>> >> >>> I know all these could be be calculated, but with more OSDs, it is
>> >> >>> convenient to have it all available at a glance<div
>> >> >>> id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
>> >> >>> <table style="border-top: 1px solid #D3D4DE;">
>> >> >>>         <tr>
>> >> >>>         <td style="width: 55px; padding-top: 13px;"><a
>> >> >>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>> >> >>> target="_blank"><img
>> >> >>> src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
>> >> >>> alt="" width="46" height="29" style="width: 46px; height: 29px;"
>> >> >>> /></a></td>
>> >> >>>                 <td style="width: 470px; padding-top: 12px; color: #41424e;
>> >> >>> font-size: 13px; font-family: Arial, Helvetica, sans-serif;
>> >> >>> line-height: 18px;">Virus-free. <a
>> >> >>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>> >> >>> target="_blank" style="color: #4453ea;">www.avg.com</a>
>> >> >>>                 </td>
>> >> >>>         </tr>
>> >> >>> </table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
>> >> >>> height="1"></a></div>
>> >> >>> --
>> >> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >>> the body of a message to majordomo@vger.kernel.org
>> >> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>>
>>
