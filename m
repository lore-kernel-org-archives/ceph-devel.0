From: Nathan Cutler <ncutler-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Mon, 11 Sep 2017 22:43:37 +0200
Message-ID: <e7f5851f-23f2-0d77-d039-56fa46900a35@suse.cz>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

 From a backporter's perspective, the appealing options are the ones 
that reduce the number of stable releases in maintenance at any 
particular time.

In the current practice, there are always at least two LTS releases, and 
sometimes a non-LTS release as well, that are "live" and supposed to be 
getting backports. For example:

* when kraken was released, hammer and jewel were "live LTS" and kraken 
was "live non-LTS", for a total of three live releases.

* when luminous was released, hammer and kraken were declared EoL and 
there are now only two "live LTS" releases and no "live non-LTS".

During the period when there are three live releases, almost every 
bugfix seen as warranting a backport gets marked for backport to the two 
most recent stable releases. (For example, from January to August 2017 
with very few exceptions tracker issues got marked "Backport: jewel, 
kraken", not just "Backport: jewel".) This, of course, doubled the 
backporting workload, simply because if a bug is severe enough to 
backport to the most recent non-LTS release, it must be severe enough to 
be backported to the most recent LTS release as well. Unfortunately, 
there aren't enough developers working on backports to cover this double 
workload, so in practice the non-LTS release gets insufficient attention.

A "train" model could lower this backporting workload if it was 
accompanied by a declaration that the n-1 release gets backports for all 
important bugfixes and n-2 gets backports for critical bugfixes only 
(and n-3 gets EOLed).

Nathan
