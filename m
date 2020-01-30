From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] rbd: optimize barrier usage for Rmw atomic bitops
Date: Thu, 30 Jan 2020 07:02:06 -0800
Message-ID: <20200130150206.gdqn3bspghd2xtwz@linux-p48b>
References: <20200129181253.24999-1-dave@stgolabs.net>
 <CAOi1vP-75uoBBsnX262WoVL_jNreiSgnGmtytDKcsUE==ny2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP-75uoBBsnX262WoVL_jNreiSgnGmtytDKcsUE==ny2Jw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dbueso@suse.de>
List-Id: ceph-devel.vger.kernel.org

On Thu, 30 Jan 2020, Ilya Dryomov wrote:

>I don't think these barriers are needed at all.  I'll remove them.

Even better, thanks.
