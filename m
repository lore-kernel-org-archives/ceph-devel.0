From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: subpackages for mgr modules
Date: Mon, 22 May 2017 10:51:07 +0200
Message-ID: <f5cb3d6f-ca63-9eae-461b-26561f014919@digiware.nl>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
 <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
 <CALe9h7eXUq-aRdOPLjDtRMFg_0bEUEHNuLR7G=QaONPZgFXOKg@mail.gmail.com>
 <186fe839-5725-0772-de54-83bac875eabd@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:13945 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbdEVIvO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 May 2017 04:51:14 -0400
In-Reply-To: <186fe839-5725-0772-de54-83bac875eabd@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>, John Spray <jspray@redhat.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 22-05-17 10:22, Tim Serong wrote:
> On 05/22/2017 08:31 AM, John Spray wrote:
>> On Fri, May 19, 2017 at 7:25 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
>>> On Fri, May 19, 2017 at 12:19 AM, Tim Serong <tserong@suse.com> wrote:
>>>> We can't have mgr just load everything that exists (someone might want
>>>> to disable some modules, without necessarily uninstalling them).
>>>
>>> I'm curious why not?
>>
>> Perhaps "can't" is too strong a word, but the way it only loads
>> explicitly enabled modules is intentional.
>>
>> The thinking was...
>> 1. It's not a given that every module will be packaged independently.
>> That's not necessarily going to be useful in all cases -- if/when we
>> reach a point where some modules are so ubiquitous that we want them
>> everywhere, then having lots of separate packages may not be
>> desirable.  I'm thinking back to things like the
>> gstreamer-plugins-good/bad/ugly packaging, and the bajillion apache
>> sub-packages -- as a user I usually find this stuff really frustrating
>> because I have a big root partition and my life is simpler if I just
>> pre-emptively have all the modules (but that doesn't mean I want them
>> all running).
>> 2. Which packages are installed on a system is usually something
>> controlled by an external tool, which tends to be different on
>> different sites/in diffferent products.  Consequently, the exact steps
>> required to turn off a module are not going to be consistent across
>> sites.  It is not a given that a support/admin person will know how to
>> turn off an individual package, unless they're also the person who
>> configured whatever orchestration tool was installing packages.
> 
> What John said.  I might not mind having installation of a package
> trigger default enablement of something (depends on the service), but I
> really don't like the idea of being required to uninstall something in
> order to disable it.  In addition to the above, even if I *am* the
> person immediately responsible for installing packages on a system and I
> know what they all are, I can't necessarily guarantee that package repos
> are always available, or that if available their content won't change.
> This causes problems if I uninstall something to disable it, then later
> want to re-enable it.
> 
> Here's a fun possible edge case: install a module, then later decide to
> disable it temporarily by uninstalling it.  Later still, I want to
> re-enable it, but meanwhile updates to ceph have been released in my
> distro's update repo.  I can no longer install the module which matches
> the version of ceph I have installed, and so need to upgrade my base
> ceph packages too in order to install the module I want to enable.
> 
>> 3. The "install to enable" convention is more welcome on some distros
>> than others.  For example, debian (I think) historically did/does this
>> for services, RPM distros historically didn't.
> 
> Some services will be enabled by default if installed on openSUSE and
> SLE now.  But not very many :)  See
> https://build.opensuse.org/package/view_file/openSUSE:Factory/systemd-presets-branding-openSUSE/default-openSUSE.preset?expand=1
> 
>>>
>>> Ceph is already hard to configure, and "install to enable / uninstall
>>> to disable" would make it simpler to use.
>>
>> My preferred solution would be mon commands for toggling modules "ceph
>> mgr module [enable|disable] <module>", and a record in the MgrMap that
>> says which are enabled.  There would be a bit of extra data in the mgr
>> beacon message for the daemons to tell the MgrMonitor which modules
>> are available.  The MgrMonitor could also raise a health warning if
>> the mgr daemons have inconsistent plugins.
>>
>> The major advantage of doing that is that all the mgr daemons see the
>> same setting.  That way, if someone enables a module on one of their
>> mgr nodes, they don't get a nasty shock when a failover happens and
>> the module is gone on the node they failed over to.
>>
>> It would also let them do it without having to go and directly log
>> into each of their mgr nodes to make a change (as they currently have
>> to do with config files, or would also have to do with package
>> install/uninstall or symlinks).

Just 2 FreeBSD cts. It is the modus there that installation is just a
"get the software step", nothing is automagically enabled. As not to
surprise the sysadmin with servers running that he/she has not
configured to their liking.

Another valid point is versioning. FreeBSD has quarterly package
building releases. Once you cross that line for a new release. It could
be that you need to upgrade quite some tools to actually have a new and
compatible set of applications.
So unstall to disable will very likely get you into trouble.

Next to the fact that I have been caught in the module-jungle that John
references to more that once. Especially Apache/php/php-modules and
security issue were/are a notorious pain.

--WjW


