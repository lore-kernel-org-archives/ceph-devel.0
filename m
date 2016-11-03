From: Tim Serong <tserong-IBi9RG/b67k@public.gmane.org>
Subject: Introducing DeepSea: A tool for deploying Ceph using
	Salt
Date: Thu, 3 Nov 2016 16:52:20 +1100
Message-ID: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi All,

I thought I should make a little noise about a project some of us at
SUSE have been working on, called DeepSea.  It's a collection of Salt
states, runners and modules for orchestrating deployment of Ceph
clusters.  To help everyone get a feel for it, I've written a blog post
which walks through using DeepSea to set up a small test cluster:

  http://ourobengr.com/2016/11/hello-salty-goodness/

If you'd like to try it out yourself, the code is on GitHub:

  https://github.com/SUSE/DeepSea

More detailed documentation can be found at:

  https://github.com/SUSE/DeepSea/wiki/intro
  https://github.com/SUSE/DeepSea/wiki/management
  https://github.com/SUSE/DeepSea/wiki/policy

Usual story: feedback, issues, pull requests are all welcome ;)

Enjoy,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong-IBi9RG/b67k@public.gmane.org
