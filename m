From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] lib/vsprintf: add snprintf_noterm
Date: Fri, 14 Jun 2019 19:58:23 -0700
Message-ID: <75c8f066c3aa2e20db2e1554a4d28c20b2952724.camel@perches.com>
References: <20190614134625.6870-1-jlayton@kernel.org>
         <20190614134625.6870-2-jlayton@kernel.org>
         <CAAM7YAnZ=NtsOuR0Pm82fWCSUdFLkJ7NLNk+fNK9+T4viW=_1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAnZ=NtsOuR0Pm82fWCSUdFLkJ7NLNk+fNK9+T4viW=_1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, agruenba@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Sat, 2019-06-15 at 10:41 +0800, Yan, Zheng wrote:
> On Fri, Jun 14, 2019 at 9:48 PM Jeff Layton <jlayton@kernel.org> wrote:
> > The getxattr interface returns a length after filling out the value
> > buffer, and the convention with xattrs is to not NULL terminate string
> > data.
> > 
> > CephFS implements some virtual xattrs by using snprintf to fill the
> > buffer, but that always NULL terminates the string. If userland sends
> > down a buffer that is just the right length to hold the text without
> > termination then we end up truncating the value.
> > 
> > Factor the formatting piece of vsnprintf into a separate helper
> > function, and have vsnprintf call that and then do the NULL termination
> > afterward. Then add a snprintf_noterm function that calls the new helper
> > to populate the string but skips the termination.

Is this function really necessary enough to add
the additional stack use to the generic case?

Why not add have this function call vsnprintf
and then terminate the string separately?
