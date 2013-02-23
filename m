From: Sage Weil <sage@inktank.com>
Subject: Re: Mon losing touch with OSDs
Date: Fri, 22 Feb 2013 17:52:11 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302221751200.19172@cobra.newdream.net>
References: <20130219030202.GA5010@onthe.net.au> <20130220020703.GA8567@onthe.net.au> <20130222030614.GA13873@onthe.net.au> <alpine.DEB.2.00.1302221344550.5703@cobra.newdream.net> <20130222233555.GA9173@onthe.net.au> <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
 <20130223000843.GA10200@onthe.net.au> <alpine.DEB.2.00.1302221612230.5703@cobra.newdream.net> <20130223005724.GB8844@onthe.net.au> <alpine.DEB.2.00.1302221728550.19172@cobra.newdream.net> <20130223014908.GA9749@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45718 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab3BWBwM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 20:52:12 -0500
In-Reply-To: <20130223014908.GA9749@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 Feb 2013, Chris Dunlop wrote:
> On Fri, Feb 22, 2013 at 05:30:04PM -0800, Sage Weil wrote:
> > On Sat, 23 Feb 2013, Chris Dunlop wrote:
> >> On Fri, Feb 22, 2013 at 04:13:21PM -0800, Sage Weil wrote:
> >>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
> >>>> On Fri, Feb 22, 2013 at 03:43:22PM -0800, Sage Weil wrote:
> >>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
> >>>>>> On Fri, Feb 22, 2013 at 01:57:32PM -0800, Sage Weil wrote:
> >>>>>>> I just looked at the logs.  I can't tell what happend to cause that 10 
> >>>>>>> second delay.. strangely, messages were passing from 0 -> 1, but nothing 
> >>>>>>> came back from 1 -> 0 (although 1 was queuing, if not sending, them).
> >>>> 
> >>>> Is there any way of telling where they were delayed, i.e. in the 1's output
> >>>> queue or 0's input queue?
> >>> 
> >>> Yeah, if you bump it up to 'debug ms = 20'.  Be aware that that will 
> >>> generate a lot of logging, though.
> >> 
> >> I really don't want to load the system with too much logging, but I'm happy
> >> modifying code...  Are there specific interesting debug outputs which I can
> >> modify so they're output under "ms = 1"?
> > 
> > I'm basically interested in everything in writer() and write_message(), 
> > and reader() and read_message()...
> 
> Like this?

Yeah.  You could do 2 instead of 1 so you can turn it down.  I suspect 
that this is the lions share of what debug 20 will spam to the log, but 
hopefully the load is manageable!

sage



> ----------------------------------------------------------------------
> diff --git a/src/msg/Pipe.cc b/src/msg/Pipe.cc
> index 37b1eeb..db4774f 100644
> --- a/src/msg/Pipe.cc
> +++ b/src/msg/Pipe.cc
> @@ -1263,7 +1263,7 @@ void Pipe::reader()
>  
>      // sleep if (re)connecting
>      if (state == STATE_STANDBY) {
> -      ldout(msgr->cct,20) << "reader sleeping during reconnect|standby" << dendl;
> +      ldout(msgr->cct, 1) << "reader sleeping during reconnect|standby" << dendl;
>        cond.Wait(pipe_lock);
>        continue;
>      }
> @@ -1272,28 +1272,28 @@ void Pipe::reader()
>  
>      char buf[80];
>      char tag = -1;
> -    ldout(msgr->cct,20) << "reader reading tag..." << dendl;
> +    ldout(msgr->cct, 1) << "reader reading tag..." << dendl;
>      if (tcp_read((char*)&tag, 1) < 0) {
>        pipe_lock.Lock();
> -      ldout(msgr->cct,2) << "reader couldn't read tag, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> +      ldout(msgr->cct, 1) << "reader couldn't read tag, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
>        fault(true);
>        continue;
>      }
>  
>      if (tag == CEPH_MSGR_TAG_KEEPALIVE) {
> -      ldout(msgr->cct,20) << "reader got KEEPALIVE" << dendl;
> +      ldout(msgr->cct, 1) << "reader got KEEPALIVE" << dendl;
>        pipe_lock.Lock();
>        continue;
>      }
>  
>      // open ...
>      if (tag == CEPH_MSGR_TAG_ACK) {
> -      ldout(msgr->cct,20) << "reader got ACK" << dendl;
> +      ldout(msgr->cct, 1) << "reader got ACK" << dendl;
>        ceph_le64 seq;
>        int rc = tcp_read((char*)&seq, sizeof(seq));
>        pipe_lock.Lock();
>        if (rc < 0) {
> -	ldout(msgr->cct,2) << "reader couldn't read ack seq, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> +	ldout(msgr->cct, 1) << "reader couldn't read ack seq, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
>  	fault(true);
>        } else if (state != STATE_CLOSED) {
>          handle_ack(seq);
> @@ -1302,7 +1302,7 @@ void Pipe::reader()
>      }
>  
>      else if (tag == CEPH_MSGR_TAG_MSG) {
> -      ldout(msgr->cct,20) << "reader got MSG" << dendl;
> +      ldout(msgr->cct, 1) << "reader got MSG" << dendl;
>        Message *m = 0;
>        int r = read_message(&m);
>  
> @@ -1342,7 +1342,7 @@ void Pipe::reader()
>  
>        cond.Signal();  // wake up writer, to ack this
>        
> -      ldout(msgr->cct,10) << "reader got message "
> +      ldout(msgr->cct, 1) << "reader got message "
>  	       << m->get_seq() << " " << m << " " << *m
>  	       << dendl;
>  
> @@ -1360,7 +1360,7 @@ void Pipe::reader()
>      } 
>      
>      else if (tag == CEPH_MSGR_TAG_CLOSE) {
> -      ldout(msgr->cct,20) << "reader got CLOSE" << dendl;
> +      ldout(msgr->cct, 1) << "reader got CLOSE" << dendl;
>        pipe_lock.Lock();
>        if (state == STATE_CLOSING) {
>  	state = STATE_CLOSED;
> @@ -1383,7 +1383,7 @@ void Pipe::reader()
>    reader_running = false;
>    reader_needs_join = true;
>    unlock_maybe_reap();
> -  ldout(msgr->cct,10) << "reader done" << dendl;
> +  ldout(msgr->cct, 1) << "reader done" << dendl;
>  }
>  
>  /* write msgs to socket.
> @@ -1395,7 +1395,7 @@ void Pipe::writer()
>  
>    pipe_lock.Lock();
>    while (state != STATE_CLOSED) {// && state != STATE_WAIT) {
> -    ldout(msgr->cct,10) << "writer: state = " << get_state_name()
> +    ldout(msgr->cct, 1) << "writer: state = " << get_state_name()
>  			<< " policy.server=" << policy.server << dendl;
>  
>      // standby?
> @@ -1413,7 +1413,7 @@ void Pipe::writer()
>      
>      if (state == STATE_CLOSING) {
>        // write close tag
> -      ldout(msgr->cct,20) << "writer writing CLOSE tag" << dendl;
> +      ldout(msgr->cct, 1) << "writer writing CLOSE tag" << dendl;
>        char tag = CEPH_MSGR_TAG_CLOSE;
>        state = STATE_CLOSED;
>        state_closed.set(1);
> @@ -1436,7 +1436,7 @@ void Pipe::writer()
>  	int rc = write_keepalive();
>  	pipe_lock.Lock();
>  	if (rc < 0) {
> -	  ldout(msgr->cct,2) << "writer couldn't write keepalive, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> +	  ldout(msgr->cct, 1) << "writer couldn't write keepalive, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
>  	  fault();
>   	  continue;
>  	}
> @@ -1450,7 +1450,7 @@ void Pipe::writer()
>  	int rc = write_ack(send_seq);
>  	pipe_lock.Lock();
>  	if (rc < 0) {
> -	  ldout(msgr->cct,2) << "writer couldn't write ack, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> +	  ldout(msgr->cct, 1) << "writer couldn't write ack, " << strerror_r(errno, buf, sizeof(buf)) << dendl;
>  	  fault();
>   	  continue;
>  	}
> @@ -1470,7 +1470,7 @@ void Pipe::writer()
>  	// associate message with Connection (for benefit of encode_payload)
>  	m->set_connection(connection_state->get());
>  
> -        ldout(msgr->cct,20) << "writer encoding " << m->get_seq() << " " << m << " " << *m << dendl;
> +        ldout(msgr->cct, 1) << "writer encoding " << m->get_seq() << " " << m << " " << *m << dendl;
>  
>  	// encode and copy out of *m
>  	m->encode(connection_state->get_features(), !msgr->cct->_conf->ms_nocrc);
> @@ -1485,13 +1485,13 @@ void Pipe::writer()
>  	// actually calculate and check the signature, but they should
>  	// handle the calls to sign_message and check_signature.  PLR
>  	if (session_security == NULL) {
> -	  ldout(msgr->cct, 20) << "writer no session security" << dendl;
> +	  ldout(msgr->cct, 1) << "writer no session security" << dendl;
>  	} else {
>  	  if (session_security->sign_message(m)) {
> -	    ldout(msgr->cct, 20) << "writer failed to sign seq # " << header.seq
> +	    ldout(msgr->cct, 1) << "writer failed to sign seq # " << header.seq
>  				 << "): sig = " << footer.sig << dendl;
>  	  } else {
> -	    ldout(msgr->cct, 20) << "writer signed seq # " << header.seq
> +	    ldout(msgr->cct, 1) << "writer signed seq # " << header.seq
>  				 << "): sig = " << footer.sig << dendl;
>  	  }
>  	}
> @@ -1502,7 +1502,7 @@ void Pipe::writer()
>  
>  	pipe_lock.Unlock();
>  
> -        ldout(msgr->cct,20) << "writer sending " << m->get_seq() << " " << m << dendl;
> +        ldout(msgr->cct, 1) << "writer sending " << m->get_seq() << " " << m << dendl;
>  	int rc = write_message(header, footer, blist);
>  
>  	pipe_lock.Lock();
> @@ -1517,22 +1517,22 @@ void Pipe::writer()
>      }
>      
>      if (sent.empty() && close_on_empty) {
> -      ldout(msgr->cct,10) << "writer out and sent queues empty, closing" << dendl;
> +      ldout(msgr->cct, 1) << "writer out and sent queues empty, closing" << dendl;
>        stop();
>        continue;
>      }
>  
>      // wait
> -    ldout(msgr->cct,20) << "writer sleeping" << dendl;
> +    ldout(msgr->cct, 1) << "writer sleeping" << dendl;
>      cond.Wait(pipe_lock);
>    }
>    
> -  ldout(msgr->cct,20) << "writer finishing" << dendl;
> +  ldout(msgr->cct, 1) << "writer finishing" << dendl;
>  
>    // reap?
>    writer_running = false;
>    unlock_maybe_reap();
> -  ldout(msgr->cct,10) << "writer done" << dendl;
> +  ldout(msgr->cct, 1) << "writer done" << dendl;
>  }
>  
>  void Pipe::unlock_maybe_reap()
> @@ -1596,7 +1596,7 @@ int Pipe::read_message(Message **pm)
>      header_crc = ceph_crc32c_le(0, (unsigned char *)&oldheader, sizeof(oldheader) - sizeof(oldheader.crc));
>    }
>  
> -  ldout(msgr->cct,20) << "reader got envelope type=" << header.type
> +  ldout(msgr->cct, 1) << "reader got envelope type=" << header.type
>             << " src " << entity_name_t(header.src)
>             << " front=" << header.front_len
>  	   << " data=" << header.data_len
> @@ -1620,7 +1620,7 @@ int Pipe::read_message(Message **pm)
>    uint64_t message_size = header.front_len + header.middle_len + header.data_len;
>    if (message_size) {
>      if (policy.throttler) {
> -      ldout(msgr->cct,10) << "reader wants " << message_size << " from policy throttler "
> +      ldout(msgr->cct, 1) << "reader wants " << message_size << " from policy throttler "
>  	       << policy.throttler->get_current() << "/"
>  	       << policy.throttler->get_max() << dendl;
>        waited_on_throttle = policy.throttler->get(message_size);
> @@ -1630,7 +1630,7 @@ int Pipe::read_message(Message **pm)
>      // policy throttle, as this one does not deadlock (unless dispatch
>      // blocks indefinitely, which it shouldn't).  in contrast, the
>      // policy throttle carries for the lifetime of the message.
> -    ldout(msgr->cct,10) << "reader wants " << message_size << " from dispatch throttler "
> +    ldout(msgr->cct, 1) << "reader wants " << message_size << " from dispatch throttler "
>  	     << msgr->dispatch_throttler.get_current() << "/"
>  	     << msgr->dispatch_throttler.get_max() << dendl;
>      waited_on_throttle |= msgr->dispatch_throttler.get(message_size);
> @@ -1645,7 +1645,7 @@ int Pipe::read_message(Message **pm)
>      if (tcp_read(bp.c_str(), front_len) < 0)
>        goto out_dethrottle;
>      front.push_back(bp);
> -    ldout(msgr->cct,20) << "reader got front " << front.length() << dendl;
> +    ldout(msgr->cct, 1) << "reader got front " << front.length() << dendl;
>    }
>  
>    // read middle
> @@ -1655,7 +1655,7 @@ int Pipe::read_message(Message **pm)
>      if (tcp_read(bp.c_str(), middle_len) < 0)
>        goto out_dethrottle;
>      middle.push_back(bp);
> -    ldout(msgr->cct,20) << "reader got middle " << middle.length() << dendl;
> +    ldout(msgr->cct, 1) << "reader got middle " << middle.length() << dendl;
>    }
>  
>  
> @@ -1680,7 +1680,7 @@ int Pipe::read_message(Message **pm)
>        map<tid_t,pair<bufferlist,int> >::iterator p = connection_state->rx_buffers.find(header.tid);
>        if (p != connection_state->rx_buffers.end()) {
>  	if (rxbuf.length() == 0 || p->second.second != rxbuf_version) {
> -	  ldout(msgr->cct,10) << "reader seleting rx buffer v " << p->second.second
> +	  ldout(msgr->cct, 1) << "reader seleting rx buffer v " << p->second.second
>  		   << " at offset " << offset
>  		   << " len " << p->second.first.length() << dendl;
>  	  rxbuf = p->second.first;
> @@ -1693,7 +1693,7 @@ int Pipe::read_message(Message **pm)
>  	}
>        } else {
>  	if (!newbuf.length()) {
> -	  ldout(msgr->cct,20) << "reader allocating new rx buffer at offset " << offset << dendl;
> +	  ldout(msgr->cct, 1) << "reader allocating new rx buffer at offset " << offset << dendl;
>  	  alloc_aligned_buffer(newbuf, data_len, data_off);
>  	  blp = newbuf.begin();
>  	  blp.advance(offset);
> @@ -1701,7 +1701,7 @@ int Pipe::read_message(Message **pm)
>        }
>        bufferptr bp = blp.get_current_ptr();
>        int read = MIN(bp.length(), left);
> -      ldout(msgr->cct,20) << "reader reading nonblocking into " << (void*)bp.c_str() << " len " << bp.length() << dendl;
> +      ldout(msgr->cct, 1) << "reader reading nonblocking into " << (void*)bp.c_str() << " len " << bp.length() << dendl;
>        int got = tcp_read_nonblocking(bp.c_str(), read);
>        ldout(msgr->cct,30) << "reader read " << got << " of " << read << dendl;
>        connection_state->lock.Unlock();
> @@ -1732,7 +1732,7 @@ int Pipe::read_message(Message **pm)
>    }
>    
>    aborted = (footer.flags & CEPH_MSG_FOOTER_COMPLETE) == 0;
> -  ldout(msgr->cct,10) << "aborted = " << aborted << dendl;
> +  ldout(msgr->cct, 1) << "aborted = " << aborted << dendl;
>    if (aborted) {
>      ldout(msgr->cct,0) << "reader got " << front.length() << " + " << middle.length() << " + " << data.length()
>  	    << " byte message.. ABORTED" << dendl;
> @@ -1740,7 +1740,7 @@ int Pipe::read_message(Message **pm)
>      goto out_dethrottle;
>    }
>  
> -  ldout(msgr->cct,20) << "reader got " << front.length() << " + " << middle.length() << " + " << data.length()
> +  ldout(msgr->cct, 1) << "reader got " << front.length() << " + " << middle.length() << " + " << data.length()
>  	   << " byte message" << dendl;
>    message = decode_message(msgr->cct, header, footer, front, middle, data);
>    if (!message) {
> @@ -1753,7 +1753,7 @@ int Pipe::read_message(Message **pm)
>    //
>  
>    if (session_security == NULL) {
> -    ldout(msgr->cct, 10) << "No session security set" << dendl;
> +    ldout(msgr->cct, 1) << "No session security set" << dendl;
>    } else {
>      if (session_security->check_message_signature(message)) {
>        ldout(msgr->cct, 0) << "Signature check failed" << dendl;
> @@ -1779,7 +1779,7 @@ int Pipe::read_message(Message **pm)
>    // release bytes reserved from the throttlers on failure
>    if (message_size) {
>      if (policy.throttler) {
> -      ldout(msgr->cct,10) << "reader releasing " << message_size << " to policy throttler "
> +      ldout(msgr->cct, 1) << "reader releasing " << message_size << " to policy throttler "
>  	       << policy.throttler->get_current() << "/"
>  	       << policy.throttler->get_max() << dendl;
>        policy.throttler->put(message_size);
> ----------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
