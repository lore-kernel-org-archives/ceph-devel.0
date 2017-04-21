From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 21 Apr 2017 09:33:32 +0200
Message-ID: <de44a5b4-593e-ed88-c3f4-93520fea972e@digiware.nl>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
 <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
 <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com>
 <68eaf07b-e611-fb55-ca9c-08dceb8cae14@digiware.nl>
 <5d1fbebf-243b-ece9-0a77-961f4d269c53@suse.cz>
 <CAJ4mKGZzDTN4KQxFyM0Oify-w0PvxVaX77qwXSYhhMpRGpRkDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43108 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1036078AbdDUHdg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Apr 2017 03:33:36 -0400
In-Reply-To: <CAJ4mKGZzDTN4KQxFyM0Oify-w0PvxVaX77qwXSYhhMpRGpRkDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Joao Eduardo Luis <joao@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 20-04-17 20:18, Gregory Farnum wrote:
> On Thu, Apr 20, 2017 at 11:11 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Hi Willem:
>>
>> It sounds like you are trying to use the sysvinit scripts? These have been
>> unmaintained (presumably with lots of weeds growing up) since infernalis.
>> Until now I have been assuming that all init systems other than systemd
>> (sysvinit, upstart, etc.) are deprecated in Ceph.

sysvinit => init-ceph?

If that is the case and is "abandoned", I could start making it more to
my liking to use it under FreeBSD. FreeBSD does not (yet) have this wild
choice of init systems.

Attempts to port Linux one to FreeBSD are in progress, but if they make
it to a large crowd is questionable. Unless it is incorporated in the
the FreeBSD release itself.

> Yeah. In particular, the scripts generally set up some magic to turn
> on daemons instead of enumerating them in the ceph.conf. I forget how
> the OSDs work but it's some hotplug system, and I think maybe the
> monitor scripts just look for any monitor directories and start them?
> Don't really remember.

So systemd is digging around in /dev and /sys proding for devices with
Ceph properties, and then starts the required ceph-(mon|osd|mds|mgr).
Or Udev-events telling systemd to act on a device that presents itself
in the system?

So on an average system there is no OSD info in /etc/ceph/ceph.conf

> -Greg
> 
>> Cheers,
>> Nathan
>>
>>
>> On 04/20/2017 10:55 AM, Willem Jan Withagen wrote:
>>>
>>> On 19-4-2017 22:47, Gregory Farnum wrote:
>>>>
>>>> On Fri, Apr 14, 2017 at 1:44 PM, Willem Jan Withagen <wjw@digiware.nl>
>>>> wrote:
>>>>>
>>>>> Having solved the first few step in ceph-deploy, I can now get to the
>>>>> point where it actually wants to start the first monitor.
>>>>> Like:
>>>>>     /usr/local/bin/ceph-deploy mon create-initial
>>>>>
>>>>> And if I look at the other platform booting the inital monitor is
>>>>> started thru the init|systemd|upstart....
>>>>>
>>>>> However under FreeBSD bsdrc I require atleast in ceph.conf
>>>>> [mon]
>>>>>     host = cephtest
>>>>>
>>>>> This is not the case on the other platforms?
>>>>>
>>>>> And how would I otherwise get this into the ceph.conf?
>>>>
>>>>
>>>> I think you're running into some annoying deployment sharp edges here.
>>>> The monitor "host" config value has gone in and out of being necessary
>>>> at various times — the whole monitor boot sequence is pretty finicky
>>>> so I've added Joao to the thread. It's possible that the way things
>>>> are default-configured in FreeBSD that's necessary to work around some
>>>> other default configs?
>>>
>>>
>>> Hi Greg, Joao,
>>>
>>> Could very well be like you describe...
>>>
>>> The call sequence in of course rather convoluted:
>>>
>>>         ceph-deply
>>>         -> remote call ceph-disk prepare
>>>         -> remote call ceph-disk activat
>>>
>>> And expect after the activate to actually have a running OSD.
>>> But to do so, ceph-disk calls the FreeBSD init script:
>>>         service ceph start osd.x
>>> that activates actual initscript:
>>>         /usr/local/etc/rc.d/ceph
>>> which calls:
>>>         init-ceph
>>>
>>> And init-ceph goes thru /etc/ceph/ceph.conf for OSD that it can start on
>>> this host. Now if the OSD description/config is not there, it doesn't
>>> get started.
>>>
>>> I'm doing the service -> rc.d/ceph -> init-ceph way, because that seems
>>> to me the natural way of doing things, and that will take into account
>>> all the settings/bits/other stuff that is set on that host.
>>> AND by keeping init-ceph as main executor, I can try to keep in pace
>>> with the code in the ceph-repo.
>>>
>>> So I guess the best fix is to add routines to add the OSD to the config
>>> and then copy it to the remote host.
>>>
>>> Why would it be not wanted on the other systems?
>>> Otherwise I'd call those adds only from the FreeBSD init part.
>>>
>>> --WjW
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>

