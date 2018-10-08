From: Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Don't upgrade to 13.2.2 if you use cephfs
Date: Mon, 8 Oct 2018 09:50:59 -0700
Message-ID: <CA+2bHPZSnFA=GS4eWGO9-zx_tgc+gz3UwXdB748BPs0jSWMmFw@mail.gmail.com>
References: <CAAM7YAnkjiujm8dqgeG6uOhPGL+ccC71Q0F15-ez=4Qgj6Fomw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YAnkjiujm8dqgeG6uOhPGL+ccC71Q0F15-ez=4Qgj6Fomw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Zheng Yan <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

+ceph-announce

On Sun, Oct 7, 2018 at 7:30 PM Yan, Zheng <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> There is a bug in v13.2.2 mds, which causes decoding purge queue to
> fail. If mds is already in damaged state, please downgrade mds to
> 13.2.1, then run 'ceph mds repaired fs_name:damaged_rank' .
>
> Sorry for all the trouble I caused.
> Yan, Zheng

This issue is being tracked here: http://tracker.ceph.com/issues/36346

The problem was caused by a backport of the wrong commit which
unfortunately was not caught. The backport was not done to Luminous;
only Mimic 13.2.2 is affected. New deployments on 13.2.2 are also
affected but do not require immediate action. A procedure for handling
upgrades of fresh deployments from 13.2.2 to 13.2.3 will be included
in the release notes for 13.2.3.
-- 
Patrick Donnelly
