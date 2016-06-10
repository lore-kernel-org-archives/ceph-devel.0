From: "Max A. Krasilnikov" <pseudo-z2DuZ08HpnDk1uMJSBkQmQ@public.gmane.org>
Subject: Re: un-even data filled on OSDs
Date: Fri, 10 Jun 2016 13:29:24 +0300
Message-ID: <20160610102924.GE35337@colocall.net>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
	<alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com>
	<CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
	<alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
	<CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
	<CA+z5DsznXSZQ2TQ9y3D0rj-fU4Yi=8GNOW89ZmwvHkvQada4cg@mail.gmail.com>
	<CANA9Uk7rNtfLrO+oT8XbfxaRdX0psPmcRHcNOKYvQ0UCrTGc=g@mail.gmail.com>
	<CANA9Uk48oQ7sjd614LzYy=7HxYfmO8qZxoQCC62wYeOdsBPFeg@mail.gmail.com>
	<CA+z5DszvAcwTO=9smdqjrLWexWGkYmjA0tE6yKVn79ezr0FVmg@mail.gmail.com>
	<CANA9Uk4Bddii2vBgExF3tM9hs2CByefep8mpUZpHKFCyzEFyXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANA9Uk4Bddii2vBgExF3tM9hs2CByefep8mpUZpHKFCyzEFyXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello! 

On Fri, Jun 10, 2016 at 07:38:10AM +0530, swamireddy wrote:

> Blair - Thanks for the details. I used to set the low priority for
> recovery during the rebalance/recovery activity.
> Even though I set the recovery_priority as 5 (instead of 1) and
> client-op_priority set as 63, some of my customers complained that
> their VMs are not reachable for a few mins/secs during the reblancing
> task. Not sure, these low priority configurations are doing the job as
> its.

It is true up to Hammer at least. I have no possibility to test it on jevel
setup due to my company policy (part of my cluster already is jevel, but I can
not continue upgrade due to direct directive).

> Thanks
> Swami

-- 
WBR, Max A. Krasilnikov
