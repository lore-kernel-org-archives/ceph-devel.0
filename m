From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Clarification of SSD journals for BTRFS rotational
	HDD
Date: Fri, 27 Feb 2015 11:08:01 -0700
Message-ID: <CAANLjFraKuDFs0T5x++9xUeuf9uFBHqj1dkVwvOP=V0PV3o-oQ@mail.gmail.com>
References: <CAANLjFpcCbfPeF4V=vgzW-oj4AJtuOCPxDcdsqeAg=-_jRhnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFpcCbfPeF4V=vgzW-oj4AJtuOCPxDcdsqeAg=-_jRhnGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Also sending to the devel list to see if they have some insight.

On Wed, Feb 25, 2015 at 3:01 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> I tried finding an answer to this on Google, but couldn't find it.
>
> Since BTRFS can parallel the journal with the write, does it make
> sense to have the journal on the SSD (because then we are forcing two
> writes instead of one)?
>
> Our plan is to have a caching tier of SSDs in front of our rotational
> HDDs and it sounds like the improvements in Hammer will really help
> here. If we can take the journals off the SSDs, that just opens up a
> bit more space for caching (albeit not much). It specifically makes
> the configuration of the host much simpler and a single SSD doesn't
> take out 5 HHDs.
>
> Thanks,
> Robert LeBlanc
