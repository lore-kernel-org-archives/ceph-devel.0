From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph OSD cache ration usage
Date: Thu, 7 Feb 2019 16:54:32 +0530
Message-ID: <CANA9Uk7JsQfw2zZi5ru02-P+L2rxipFm+mQjgu6Z2n-LRwGY+g@mail.gmail.com>
References: <CANA9Uk6Sy5=mABG3peqx-bEp7c2cwwp24=jRM+PXxqyM_uUBOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk6Sy5=mABG3peqx-bEp7c2cwwp24=jRM+PXxqyM_uUBOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello - We are using the ceph osd nodes with cache controller cache of 1G size.
Are there any recommendation for using the cache for read and write?
Here we are using - HDDs with colocated journals.
For SSD journal - 0% cache and 100% write.

Thanks

On Mon, Feb 4, 2019 at 6:07 PM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hello - We are using the ceph osd nodes with cache controller cache of 1G size.
> Are there any recommendation for using the cache for read and write?
> Here we are using - HDDs with colocated journals.
> For SSD journal - 0% cache and 100% write.
>
> Thanks
> Swami
