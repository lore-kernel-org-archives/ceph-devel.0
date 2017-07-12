From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Cmake: determening Ceph version when there is no git checkout.
Date: Wed, 12 Jul 2017 18:23:38 +0200
Message-ID: <7b55ef98-1897-3345-5192-058493897600@digiware.nl>
References: <7683db13-17fc-44a8-cb6c-bcc83048378a@digiware.nl>
 <alpine.DEB.2.11.1707111404340.3424@piezo.novalocal>
 <992deb10-b689-ebf7-947c-e7abefcdb878@digiware.nl>
 <alpine.DEB.2.11.1707111434220.3424@piezo.novalocal>
 <32308ccf-139a-b37a-7282-8bb414c8a146@digiware.nl>
 <CALqRxCx9DUA9fP-mWCFBj5Vk8hXEZX+N0ekUmrdpGG0pQXDP+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:58482 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753135AbdGLQXm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 12:23:42 -0400
In-Reply-To: <CALqRxCx9DUA9fP-mWCFBj5Vk8hXEZX+N0ekUmrdpGG0pQXDP+Q@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On 12-7-2017 18:05, Ken Dreyer wrote:
> On Tue, Jul 11, 2017 at 9:42 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>> Alternative would be to create a dir on download.ceph.com with a hash
>> file per released version to download??
> 
> I'm not quite sure what you're asking, mind providing an example?

	http://download.ceph.com/tarballs/ceph_12.1.0.orig.tar.gz
and then something like
	http://download.ceph.com/tarballs/ceph_12.1.0.hash.txt
which contains the hash that goes with the version.

Also note that the sha256 are only created for older versions.
So "verification" for correctness with the tgz's is not possible.

--WjW

