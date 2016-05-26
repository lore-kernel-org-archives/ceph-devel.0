From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 14:13:54 -0700
Message-ID: <CA+55aFx=v0SYBURwJbFNdPW0nGpzJrVO2b0BcqJEonZedizm2A@mail.gmail.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
	<CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, May 26, 2016 at 11:31 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Pulled and then immediately unpulled again.

.. and having thought it over, I ended up re-pulling again, so now
it's going through my build test.

Consider this discussion a strong encouragement to *not* do this in
the future - sending me pull requests at the end of the merge window
without them having been in linux-next is a no-no, unless those pull
requests are small and trivial (or have fixes that I'd pull even
outside the merge window, of course).

             Linus
