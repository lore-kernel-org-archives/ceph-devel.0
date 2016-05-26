From: Sage Weil <sweil@redhat.com>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 15:02:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605261446230.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com> <CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 26 May 2016, Linus Torvalds wrote:
> On Thu, May 26, 2016 at 11:18 AM, Sage Weil <sweil@redhat.com> wrote:
> >
> > Please pull the following Ceph updates from
> 
> Why was that branch rebased yesterday?
> 
> What has been in next, if anything?
> 
> And if something has been in next, why was _that_ not sent to me?

The branch was assembled in its current form yesterday and is included in 
today's -next:

	https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=e536030934aebf049fe6aaebc58dd37aeee21840

The same commit went through our internal testing last night, and we've 
been testing the code for the better part of a week internally.

If you want it to bake longer in -next first, let us know.  We're not 
causing merge conflicts, and there isn't -next-based ceph testing that I'm 
aware of going on outside of our own QA environment, so I'm not sure how 
valuable it is, but I'm happy to delay before sending a pull request if 
that's what you want to see.

Thanks-
sage
