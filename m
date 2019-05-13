From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH 4/5] ceph: fix improper use of smp_mb__before_atomic()
Date: Tue, 14 May 2019 00:47:03 +0200
Message-ID: <20190513224703.GA2957@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-5-git-send-email-andrea.parri@amarulasolutions.com>
 <20190430082332.GB2677@hirez.programming.kicks-ass.net>
 <CAAM7YA=YOM79GJK8b7OOQbzT_-sYRD2UFHYithY7Li1yQt5Hog@mail.gmail.com>
 <20190509205452.GA4359@andrea>
 <6956e700-ef56-7f20-4e6c-3ad86c9fd89e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6956e700-ef56-7f20-4e6c-3ad86c9fd89e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: ceph-devel.vger.kernel.org

> >>>         /*
> >>>          * XXX: the comment that explain this barrier goes here.
> >>>          */
> >>>
> >>
> >>makes sure operations that setup readdir cache (update page cache and
> >>i_size) are strongly ordered with following atomic64_set.
> >
> >Thanks for the suggestion, Yan.
> >
> >To be clear: would you like me to integrate your comment and resend?
> >any other suggestions?
> >
> 
> Yes, please

Will do: I'll let the merge window close and send v2 on top of -rc1.

Thanks,
  Andrea
