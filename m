From: Alexandre Oliva <oliva-mXXj517/zsQ@public.gmane.org>
Subject: Re: v0.75 released
Date: Tue, 21 Jan 2014 13:33:45 -0200
Message-ID: <orbnz5qrhi.fsf@livre.home>
References: <alpine.DEB.2.00.1401141941070.8325@cobra.newdream.net>
	<ord2jpvl4e.fsf@livre.home>
	<alpine.DEB.2.00.1401182057250.17005@cobra.newdream.net>
	<alpine.DEB.2.00.1401182125150.17005@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1401182125150.17005-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org> (Sage
	Weil's message of "Sat, 18 Jan 2014 21:27:11 -0800 (PST)")
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Jan 19, 2014, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Sat, 18 Jan 2014, Sage Weil wrote:

>> Which also means this will bite anybody who ran emperor, too.  I think I 
>> need to introduce some pool flag or something indicating whether the dirty 
>> stats should be scrubbed or not, set only on new pools?

> Pushed wip-7184.

How about clearing the dirty_stats_invalid flag if, at the end of a
scrub, the dirty stats didn't mismatch?

Then, old PGs that, with 0.75, were marked inconsistent state and then
got repaired, still with v13 stats, won't have to go through *another*
round of repair before dirty mismatches are taken seriously again.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist     Red Hat Brazil Toolchain Engineer
