From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 21 Apr 2017 11:46:04 +0200
Message-ID: <77cc3068-e0d3-e834-6901-5b69a4a6b166@digiware.nl>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
 <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
 <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com>
 <68eaf07b-e611-fb55-ca9c-08dceb8cae14@digiware.nl>
 <5d1fbebf-243b-ece9-0a77-961f4d269c53@suse.cz>
 <20170421091325.t23jra6qdbfjgjeh@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43684 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971117AbdDUJqK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Apr 2017 05:46:10 -0400
In-Reply-To: <20170421091325.t23jra6qdbfjgjeh@nora.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Gregory Farnum <gfarnum@redhat.com>, Joao Eduardo Luis <joao@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 21-04-17 11:13, Fabian Grünbichler wrote:
> On Thu, Apr 20, 2017 at 08:11:38PM +0200, Nathan Cutler wrote:
>> Hi Willem:
>>
>> It sounds like you are trying to use the sysvinit scripts? These have been
>> unmaintained (presumably with lots of weeds growing up) since infernalis.
>> Until now I have been assuming that all init systems other than systemd
>> (sysvinit, upstart, etc.) are deprecated in Ceph.
> 
> Slightly OT, but AFAICT http://tracker.ceph.com/issues/18305 still
> applies to the official ceph.com Kraken Debian packages, i.e., ceph-base
> installs and activates the init.d script, which then races against the
> (udev-activated) ceph-osd systemd units. If anything except systemd is
> indeed deprecated, I wonder why the Debian packages (still) ship AND
> activate both systemd units and Sys V init scripts?
> 
> (Note that the proposed fix probably does not apply as is anymore,
> because ceph-disk and the systemd units have been changed in the
> meantime).
> 
Thanx for the headsup.

It means that I cannot get my axe out and start whacking at init-ceph
just at will.

--WjW
