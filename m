From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD image name constraints
Date: Mon, 11 Apr 2016 10:29:10 -0400 (EDT)
Message-ID: <1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com>
References: <5707A2C4.3030102@corp.ovh.com> <20160408202919.GA8043@gmail.com> <570B6436.9040109@corp.ovh.com> <20160411093703.GA17959@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57178 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbcDKO3V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 10:29:21 -0400
In-Reply-To: <20160411093703.GA17959@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: =?utf-8?Q?Bart=C5=82omiej_=C5=9Awi=C4=99cki?= <bartlomiej.swiecki@corp.ovh.com>, Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

> > >
> > >You can still bypass the limitation by using --pool, --image, and
> > >--snap options, and I would recommend to always use these in scripts
> > >instead of specs.
> > >
> > True, but even if I specify image name with --image argument it still goes
> > through rbd::utils::extract_spec function (or set_pool_image_name in old
> > code) so there's no way to put there any raw name I want.
> 
> Ah, it is rather unfortunate!
> 
> I expected that with --image argument you could only specify image
> name, but now I see we even have a comment in the code:
> 
>     // despite the separate pool and snapshot name options,
>     // we can also specify them via the image option
> 
> I would prefer if it was possible to specify only image name with
> --image argument, but I guess it would cause backward compatibility
> issues, so, the simplest solution may be to ease the regexp to:
> 
>   "^(?:([^/@]+)/)?([^@]+)(?:@([^@]+))?$" ?
> 
> Or may be even:
> 
>   "^(?:([^/@]+)/)?([^@]+)(?:@(.+))?$" ?
> 

It would probably make sense to relax it for non-create operations and use a strict regex for create/clone/import/rename operations.  

-- 

Jason Dillaman 

