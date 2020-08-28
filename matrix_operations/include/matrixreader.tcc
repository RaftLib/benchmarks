/**
 * 1) height * width / worker threads
 * if heigth * wdith % != 1 then +1 for one thread 
 * 
 */



class work_divider
{
    /**
     * simple static function to return the amount of work 
     * to be done by each worker thread. The work is given
     * in the thread_assignments vector as an integer of
     * units for number of dot products to be sent to each. 
     */
    static void get_dps_per_thread( const std::size_t height,
                                    const std::size_t width,
                                    const std::size_t workers,
                                    const std::size_t dp_width,
                                    std::vector< std::size_t > &thread_assignments )
    {
        
    }
}
