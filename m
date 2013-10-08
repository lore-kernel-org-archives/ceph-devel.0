From: Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ceph-create-keys hung
Date: Tue, 08 Oct 2013 10:14:11 +0100
Message-ID: <5253CCE3.4060808@inktank.com>
References: <CAK72ynaw9YqN8AUae2N1ZdkCaMhCEbQ8tKn_tYB=RUk6e7RFdA@mail.gmail.com>
	<524D86C3.3010307@inktank.com>
	<CAK72ynaai=RAPvWoyc7p9Qrh1dFkuxUiEL3rzDRv66zoVySA_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAK72ynaai=RAPvWoyc7p9Qrh1dFkuxUiEL3rzDRv66zoVySA_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Abhay Sachan <abhaysac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 08/10/13 05:40, Abhay Sachan wrote:
> Hi Joao,
> Thanks for replying. All of my monitors are up and running and connected
> to each other. "ceph -s" is failing on the cluster with following error:
>
> 2013-10-07 10:12:25.099261 7fd1b948d700 -1 monclient(hunting): ERROR:
> missing keyring, cannot use cephx for authentication
> 2013-10-07 10:12:25.099271 7fd1b948d700  0 librados: client.admin
> initialization error (2) No such file or directory
> Error connecting to cluster: ObjectNotFound

This says it all.  You're somehow missing your keyring.  Or maybe you're 
not but you're keeping it in a non-default location and you're not 
specifying a path to it either on your ceph.conf or via '--keyring <path>'.


> And the logs on each monitor has lots of entries like this:
> NODE 1:
>
> 2013-10-07 03:58:51.153847 7ff2864c6700  0
> mon.jul@0(probing).data_health(0) update_stats avail 76% total 42332700
> used 7901820 avail 32280480
> 2013-10-07 03:59:51.154051 7ff2864c6700  0
> mon.jul@0(probing).data_health(0) update_stats avail 76% total 42332700
> used 7901832 avail 32280468
> 2013-10-07 04:00:51.154256 7ff2864c6700  0
> mon.jul@0(probing).data_health(0) update_stats avail 76% total 42332700
> used 7901828 avail 32280472

Those messages are simply reports on the mon store's storage capacity.


   -Joao

>
>
> Regards,
> Abhay
>
> On Thu, Oct 3, 2013 at 8:31 PM, Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
> <mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>> wrote:
>
>     On 10/03/2013 02:44 PM, Abhay Sachan wrote:
>
>         Hi All,
>         I have tried setting up a ceph cluster with 3 nodes (3
>         monitors). I am
>         using RHEL 6.4 as OS with dumpling(0.67.3) release. Ceph cluster
>         creation (using ceph-deploy as well as mkcephfs), ceph-creates-keys
>         doesn't return on any of the servers. Whereas, if I create a cluster
>         with only 1 node (1 monitor), key creation goes through. Has anybody
>         seen this problem or any ideas what I might be missing??
>
>         Regards,
>         Abhay
>
>
>     Those symptoms tell me that your monitors are not forming quorum.
>     'ceph-create-keys' needs the monitors to first establish a quorum,
>     otherwise it will hang waiting for that to happen.
>
>     Please make sure all your monitors are running.  If so, try running
>     'ceph -s' on your cluster.  If that hangs as well, try accessing
>     each monitor's admin socket to check what's happening [1].  If that
>     too fails, try looking into the logs for something obviously wrong.
>       If you are not able to discern anything useful at that point,
>     upload the logs to some place and point us to them -- we'll then be
>     happy to take a look.
>
>     Hope this helps.
>
>        -Joao
>
>     --
>     Joao Eduardo Luis
>     Software Engineer | http://inktank.com | http://ceph.com
>
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
