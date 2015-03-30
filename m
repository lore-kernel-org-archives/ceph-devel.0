From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Fedora 21 packages
Date: Mon, 30 Mar 2015 10:54:56 -0500
Message-ID: <551971D0.4070300@redhat.com>
References: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com> <alpine.DEB.2.00.1503281034470.18934@cobra.newdream.net> <551874D0.1090900@redhat.com> <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net> <20150330151731.GA17645@host1.jankratochvil.net> <alpine.DEB.2.00.1503300832280.23387@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbbC3PzA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Mar 2015 11:55:00 -0400
In-Reply-To: <alpine.DEB.2.00.1503300832280.23387@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Jan Kratochvil <jan.kratochvil@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 03/30/2015 10:34 AM, Sage Weil wrote:
> On Mon, 30 Mar 2015, Jan Kratochvil wrote:
>> On Mon, 30 Mar 2015 01:45:55 +0200, Sage Weil wrote:
>>> These packages are from downstream Fedora.  What's missing are more up
>>> to date packages built and published at ceph.com.  The distro only ships
>>> one version of Ceph (the most recent LTS), while ceph.com gets everything
>>> and ceph-deploy let's you choose which stable series or development branch
>>> to install.  We're also not doing any testing on f21.
>>
>> That's not the Fedora way.  LTS-like packages are not for Fedora, those are
>> for CentOS/RHEL (but where Ceph LTS is already present).  Latest development
>> packages are for Fedora Rawhide.  And for other cases there is also
>> https://fedorahosted.org/copr .
>
> In that case, I think the latest stable release (e.g., giant) should go in
> Fedora.  Maybe we could put the latest development release in Rawhide, but
> I'm nto sure.  They're really not intended for end users.
>
> sage
>

FWIW, I've got some of our performance gear on fedora 20 right now and 
happily use the gitbuilder packages (though there are some annoying 
dependency issues that require different excludes during the yum 
installation).  It's incredibly convenient to be able to simply change 
the repo and grab the newest build from different versions the same way 
we do in Ubuntu.  Hopefully regardless of whatever other decisions are 
made, we can retain this kind of workflow with the gitbuilder releases.

Mark

>>
>> I have filed for Fedora-shipped ceph-deploy:
>> 	https://bugzilla.redhat.com/show_bug.cgi?id=1207275
>>
>>
>> Jan
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
