From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Mon, 3 Feb 2014 21:42:58 +0000
Message-ID: <20140203214258.GB10323@ZenIV.linux.org.uk>
References: <1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
 <CA+55aFwTuBDHgQoTymr8OtE-+k=+pX0T_eb+fff0K+Pa3C-g-Q@mail.gmail.com>
 <20140130075421.GA10050@infradead.org>
 <CA+55aFxbVFpy8Y8P5fMCmmTSGbFxU9dTbOj9uTH+fKWGUzwgNg@mail.gmail.com>
 <20140203102943.GF11829@infradead.org>
 <CA+55aFytvTPdBsv6BwSomUGWXZ_tKP=BxaeJ7FXBft0JNnjBCQ@mail.gmail.com>
 <20140203211955.GY10323@ZenIV.linux.org.uk>
 <20140203212447.GA4843@infradead.org>
 <20140203213153.GZ10323@ZenIV.linux.org.uk>
 <CA+55aFwsZtgsgirO0LJu4D1ZqQkgLBZcMk_w_7BTHeysz==gEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwsZtgsgirO0LJu4D1ZqQkgLBZcMk_w_7BTHeysz==gEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Guangliang Zhao <lucienchao@gmail.com>, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 03, 2014 at 01:37:03PM -0800, Linus Torvalds wrote:
> On Mon, Feb 3, 2014 at 1:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Yes, and...?  CIFS also doesn't have hardlinks, so _there_ d_find_alias()
> > is just fine.
> 
> Hmm? I'm pretty sure cifs can actually have hardlinks.

*UGH*

How the hell does it...  Oh, right - samba on Unix server.  I really wonder
how well do Windows clients deal with those...

Crap...  I reall hate that prototype change ;-/
