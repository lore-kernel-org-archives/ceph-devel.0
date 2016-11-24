From: Tim Serong <tserong-IBi9RG/b67k@public.gmane.org>
Subject: Re: Introducing DeepSea: A tool for deploying Ceph
 using Salt
Date: Thu, 24 Nov 2016 19:09:46 +1100
Message-ID: <5928afcf-2afe-18ad-a1c4-9786d0087347@suse.com>
References: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>
	<CAEhqmj+DDJHFnoTAZrAwnX-7C6mkYgdAu3RKwZH=vd6-OuZD8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEhqmj+DDJHFnoTAZrAwnX-7C6mkYgdAu3RKwZH=vd6-OuZD8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Bill Sanders <billysanders-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 11/12/2016 05:30 AM, Bill Sanders wrote:
> I'm curious what the relationship is with python_ceph_cfg[0] and
> DeepSea, which have some overlap in contributors and functionality (and
> supporting organizations?).

DeepSea and python-ceph-cfg look at ceph deployment from two different
perspectives.

python-ceph-cfg is a low-level python library for doing
individual/discrete tasks necessary to deploy ceph.  So, for example, it
has methods for zapping a disk, preparing an OSD, creating a keyring,
etc.  Think of it as operating approximately on a node level (although
you could argue that's an oversimplification, as it includes functions
to check quorum status, create pools, etc., which are really cluster level).

DeepSea is a high-level user-facing tool for orchestrating ceph
deployment with salt.  So DeepSea knows how to install ceph, discover
what disks are on each node, lets you assign different roles to nodes
("these nodes will be MONs, the storage nodes will use all their spare
disks as OSDs", etc.).  Think of it as operating on a cluster level.

Regards,

Tim

> 
> [0] https://github.com/oms4suse/python-ceph-cfg
> 
> Bill Sanders
> 
> On Wed, Nov 2, 2016 at 10:52 PM, Tim Serong <tserong-IBi9RG/b67k@public.gmane.org
> <mailto:tserong-IBi9RG/b67k@public.gmane.org>> wrote:
> 
>     Hi All,
> 
>     I thought I should make a little noise about a project some of us at
>     SUSE have been working on, called DeepSea.  It's a collection of Salt
>     states, runners and modules for orchestrating deployment of Ceph
>     clusters.  To help everyone get a feel for it, I've written a blog post
>     which walks through using DeepSea to set up a small test cluster:
> 
>       http://ourobengr.com/2016/11/hello-salty-goodness/
>     <http://ourobengr.com/2016/11/hello-salty-goodness/>
> 
>     If you'd like to try it out yourself, the code is on GitHub:
> 
>       https://github.com/SUSE/DeepSea <https://github.com/SUSE/DeepSea>
> 
>     More detailed documentation can be found at:
> 
>       https://github.com/SUSE/DeepSea/wiki/intro
>     <https://github.com/SUSE/DeepSea/wiki/intro>
>       https://github.com/SUSE/DeepSea/wiki/management
>     <https://github.com/SUSE/DeepSea/wiki/management>
>       https://github.com/SUSE/DeepSea/wiki/policy
>     <https://github.com/SUSE/DeepSea/wiki/policy>
> 
>     Usual story: feedback, issues, pull requests are all welcome ;)
> 
>     Enjoy,
> 
>     Tim
>     --
>     Tim Serong
>     Senior Clustering Engineer
>     SUSE
>     tserong-IBi9RG/b67k@public.gmane.org <mailto:tserong-IBi9RG/b67k@public.gmane.org>
>     _______________________________________________
>     ceph-users mailing list
>     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>     <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>
> 
> 


-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong-IBi9RG/b67k@public.gmane.org
