From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: civetweb upstream/downstream divergence
Date: Fri, 30 Oct 2015 15:38:45 -0600
Message-ID: <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com>
References: <5631E4A5.9020003@suse.cz>
	<CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
	<20151029225738.51b8b2e5@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34298 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758993AbbJ3Vq7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 17:46:59 -0400
Received: by wmff134 with SMTP id f134so21059446wmf.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2015 14:46:58 -0700 (PDT)
In-Reply-To: <20151029225738.51b8b2e5@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 29, 2015 at 10:57 PM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Thu, 29 Oct 2015 10:58:07 -0700
> Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
>
>> We should definitely do it. We're based off civetweb 1.6, and there
>> was no official civetweb version for quite a while, but 1.7 was tagged
>> a few months ago. I made some effort and got most of our material
>> changes upstream, however, there are some changes that might need some
>> more work before we can get them merged, or might not make complete
>> sense at all.
>
> I take it Nathan is volunteering to parse the delta into logical pieces
> and identify what upstream is willing to accept, right?
>
> Dunno about SuSE, but as a Fedora packager I would prefer if we (Ceph)
> talked upstream into making regular releases and then for us to stop
> carrying it entirely. One less git submodule if nothing else.

I would heartily support the effort to get civetweb into the distros,
too, and make this a proper package with a shared library that RGW can
link against. This can be done in parallel to the "reconciling the
code content with civetweb upstream" effort of course :)

- Ken
