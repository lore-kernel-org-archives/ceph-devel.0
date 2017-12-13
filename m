From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Subject: Re: [PATCH] fs/ceph: delete unused ceph_file_layout_is_valid function
Date: Tue, 12 Dec 2017 20:52:04 -0500
Message-ID: <20171213015204.GA28668@byw>
References: <1513043801-9164-1-git-send-email-baiyaowei@cmss.chinamobile.com>
 <CAOi1vP8f3fvkWg4yiLOsnMX2nq9yHWGOPYqySiB3cFJfo55QqA@mail.gmail.com>
Reply-To: baiyaowei@cmss.chinamobile.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP8f3fvkWg4yiLOsnMX2nq9yHWGOPYqySiB3cFJfo55QqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Dec 12, 2017 at 11:15:05AM +0100, Ilya Dryomov wrote:
> On Tue, Dec 12, 2017 at 2:56 AM, Yaowei Bai
> <baiyaowei@cmss.chinamobile.com> wrote:
> > There's no users of ceph_file_layout_is_valid, remove it.
> 
> It'll get a user in the next kernel release -- we'll remove ad-hoc
> checks from ceph_calc_file_object_mapping() which is executed on every
> mapping and call ceph_file_layout_is_valid() once per layout instead.

Maybe we can re-add it when it's used indeed.
 
> 
> Thanks,
> 
>                 Ilya
