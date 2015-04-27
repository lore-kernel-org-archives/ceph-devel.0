From: "HEWLETT, Paul (Paul)** CTR **" <paul.hewlett@alcatel-lucent.com>
Subject: RE: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Mon, 27 Apr 2015 11:29:06 +0000
Message-ID: <B1C372F943D5614C80F90CC0D60D4210485991A2@FR711WXCHMBA04.zeu.alcatel-lucent.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net>
 <5488919E.4090109@redhat.com>
 <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net>
 <5488FC46.5080106@suse.com>
 <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net>
 <552C9182.5030605@suse.com>
 <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net>
 <552D3C74.2000104@redhat.com>
 <87bnip2u10.fsf@meteor.durcheinandertal.bofh>,<553E07C7.8030905@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fr-hpida-esg-02.alcatel-lucent.com ([135.245.210.21]:52320 "EHLO
	smtp-fr.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752941AbbD0L3L convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Apr 2015 07:29:11 -0400
In-Reply-To: <553E07C7.8030905@suse.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>, Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cjwatson@debian.org" <cjwatson@debian.org>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, "timm@fnal.gov" <timm@fnal.gov>, Owen Synge <osynge@suse.com>

What about making it configurable in ceph.conf or /etc/sysconfig/ceph? (or via PAM/ldap...)

That way individual users could make it a value that they know does not conflict and they will still be able to
move OSDs between nodes etc...

Paul Hewlett
Senior Systems Engineer
Velocix, Cambridge
Alcatel-Lucent
t: +44 1223 435893



________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Tim Serong [tserong@suse.com]
Sent: 27 April 2015 10:56
To: Gaudenz Steinlin; Ken Dreyer; Sage Weil
Cc: ceph-devel@vger.kernel.org; cjwatson@debian.org; ceph-maintainers@ceph.com; timm@fnal.gov; Owen Synge
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph

On 04/16/2015 03:14 AM, Gaudenz Steinlin wrote:
>
> Hi
>
> Ken Dreyer <kdreyer@redhat.com> writes:
>
>> On 04/14/2015 09:21 AM, Sage Weil wrote:
>>> I think we still want them to be static across a distro; it's the
>>> cross-distro change that will be relatively rare.  So a fixed ID from each
>>> distro family ought to be okay?
>>
>> Sounds sane to me. I've filed https://fedorahosted.org/fpc/ticket/524 to
>> request one from Fedora.
>
> I have now requested the same for Debian. If the request is granted we
> will most likely get the uid/gid 64045. Maybe others could use the same.
> It seems that only Debian has a range of reserved ids for this purpose.
> I would expect Ubuntu to use the same id, but that's up to them finally.

Fedora has rejected the request for a static UID (see
https://fedorahosted.org/fpc/ticket/524#comment:16), and I haven't made
much progress on the SUSE front.  I did suggest everyone just do what
Debian does ;) but both Fedora and SUSE people pointed out that the 64K
range isn't safe to claim, what with not being specifically reserved.

I did make one small bit of progress - I've added the ceph user and
group to rpmlint on openSUSE Factory
(https://build.opensuse.org/request/show/303537) so at least the SUSE
build won't bitch if files specified in any of the packages are owned by
ceph:ceph.

Regards,

Tim
--
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
