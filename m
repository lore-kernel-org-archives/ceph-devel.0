From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: Re: RFC: Deprecating ceph-tool commands
Date: Sat, 09 May 2015 16:01:37 +0100
Message-ID: <554E2151.4070003@suse.de>
References: <554D4CD8.6020809@suse.de> <554DCC0C.7040000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <554DCC0C.7040000-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 05/09/2015 09:57 AM, Loic Dachary wrote:
> Hi,
> 
> On 09/05/2015 01:55, Joao Eduardo Luis wrote:
>> This approach gives a lifespan of roughly 3 releases (at current rate,
>> roughly 1.5 years) before being completely dropped.  This should give
>> enough time to people to realize what has happened and adjust any
>> scripts they may have.
> 
> That sounds reasonable. 
> 
> In the python documentation I find it very convenient to have "New in X.Y.Z" next to a given API call or behavior, as well as "Deprectated since". Although release notes https://github.com/ceph/ceph/commit/e3b788a56c640fb19d8aa9464ebf5bc84c97ec6f are useful when upgrading (to answer the question "What API will break ?"), it's not the primary location I'll check when considering using something. 

Agreed, docs will have to be changed, including man pages.

  -Joao
