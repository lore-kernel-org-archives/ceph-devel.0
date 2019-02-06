From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: ceph mon_data_size_warn limits for large cluster
Date: Wed, 6 Feb 2019 12:26:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1902061225330.4436@piezo.novalocal>
References: <CANA9Uk437gWgTABHq66dw8v2KN6LqGF5DVc+ecaqoV24ABt++w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk437gWgTABHq66dw8v2KN6LqGF5DVc+ecaqoV24ABt++w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Swami

The limit is somewhat arbitrary, based on cluster sizes we had seen when 
we picked it.  In your case it should be perfectly safe to increase it.

sage


On Wed, 6 Feb 2019, M Ranga Swami Reddy wrote:

> Hello -  Are the any limits for mon_data_size for cluster with 2PB
> (with 2000+ OSDs)?
> 
> Currently it set as 15G. What is logic behind this? Can we increase
> when we get the mon_data_size_warn messages?
> 
> I am getting the mon_data_size_warn message even though there a ample
> of free space on the disk (around 300G free disk)
> 
> Earlier thread on the same discusion:
> https://www.spinics.net/lists/ceph-users/msg42456.html
> 
> Thanks
> Swami
> 
> 
> 
