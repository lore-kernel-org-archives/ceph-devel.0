From: Tim Serong <tserong@suse.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Mon, 27 Apr 2015 19:56:23 +1000
Message-ID: <553E07C7.8030905@suse.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com> <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com> <87bnip2u10.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:55484 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932066AbbD0J4m (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 27 Apr 2015 05:56:42 -0400
In-Reply-To: <87bnip2u10.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, cjwatson@debian.org, ceph-maintainers@ceph.com, timm@fnal.gov, Owen Synge <osynge@suse.com>

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
