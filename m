From: Alex Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Don't upgrade to 13.2.2 if you use cephfs
Date: Sun, 7 Oct 2018 22:21:14 -0500
Message-ID: <28a7ec84-864a-8f61-a223-b307217919ce@gmail.com>
References: <CAAM7YAnkjiujm8dqgeG6uOhPGL+ccC71Q0F15-ez=4Qgj6Fomw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YAnkjiujm8dqgeG6uOhPGL+ccC71Q0F15-ez=4Qgj6Fomw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

How is this not an emergency announcement?  Also I wonder if I can 
downgrade at all ?  I am using ceph with docker deployed with 
ceph-ansible.  I wonder if I should push downgrade or basically wait for 
the fix.  I believe, a fix needs to be provided.

Thank you,

On 10/7/2018 9:30 PM, Yan, Zheng wrote:
> There is a bug in v13.2.2 mds, which causes decoding purge queue to
> fail. If mds is already in damaged state, please downgrade mds to
> 13.2.1, then run 'ceph mds repaired fs_name:damaged_rank' .
> 
> Sorry for all the trouble I caused.
> Yan, Zheng
> 
