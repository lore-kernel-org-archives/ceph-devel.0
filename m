From: Sage Weil <sage@inktank.com>
Subject: Re: [rados] Asynchronous operations
Date: Wed, 27 Jun 2012 08:22:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206270821040.18530@cobra.newdream.net>
References: <jsecti$m2u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36426 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab2F0PWE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 11:22:04 -0400
In-Reply-To: <jsecti$m2u$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Jun 2012, Rutger ter Borg wrote:
> 
> Dear list,
> 
> I'm currently writing a Boost.Asio-like interface to librados.hpp. Most things
> are working like expected, and some things I couldn't figure out from the
> available docs and code. I have itemized a couple of questions below.
> 
> * to avoid allocations done by rados, I'm currently using
> buffer::create_static() for both reads and writes. I suppose this is ok?
> 
> * suppose you have the following code example
> 
> boost::asio::io_service ios;
> pool pool( "some pool", ios );
> 
> std::string some_data( "this is an example string of data" );
> pool.async_write_object_at( "hello", 0, boost::asio::buffer( some_data ),
> &done );
> 
> ios.run();
> 
> with respect to this interface, I have the following questions:
> 
> a) the IoCtx's synchronous read() and write() functions return the number of
> bytes read and written; is there a way to get to this number from
> AioCompletion? I would like to define the function signature for the callback
> handler (see 'done' in the example above) something like
> 
> void( const boost::system::error_code&, std::size_t )
> 
> where the second argument would be the number of bytes transferred.

There is a get_return_value() method on the AioCompletion that gives you 
bytes read (for reads).  For write operations, it is always 0 (success) or 
an error code.

> b) is it possible to cancel outstanding asynchronous operations? I.e., have
> the possibility to implement something like
> 
> pool.cancel();

Not currently.  This is probably something we should add.

sage
